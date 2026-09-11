# frozen_string_literal: true

require "json"

unless defined?(JSON.load_file)
  module JSON
    def self.load_file(path)
      JSON.load(File.read(path))
    end
  end
end

class Hash
  private def method_missing(key, *args)
    if args.empty? and key?(key.to_s)
      fetch(key.to_s)
    else
      super
    end
  end
end

def gem_version_or_nil(version)
  Gem::Version.new(version.to_s)
rescue ArgumentError
  nil
end

data = Hash.new { |h,k| h[k] = [] }

JSON.load_file("_graalvm-reachability-metadata/metadata/library-and-framework-list.json").each do |json|
  raise "Expected a single details entry for #{json.artifact} in library-and-framework-list.json" unless json.details.size == 1
  entry = json.dup
  entry.merge!(json.details.first)
  entry.delete("details")
  data[entry.artifact] << entry
end

Dir.glob('_graalvm-reachability-metadata/metadata/*/*/*.json') do |metadata_index|
  next if metadata_index.include? "/samples/" # ignore samples

  json = JSON.load_file(metadata_index)
  if json.all? { |entry| entry.is_a?(Hash) && entry['not-for-native-image'] }
    warn "Skipping #{metadata_index}: artifact is marked not-for-native-image"
    next
  end

  version_entries = json.select { |entry| entry.is_a?(Hash) && entry.key?('metadata-version') }
  if version_entries.empty?
    warn "Skipping #{metadata_index}: no metadata-version entries found"
    next
  end

  metadata_index_parts = metadata_index.split('/')
  artifact = "#{metadata_index_parts[2]}:#{metadata_index_parts[3]}"
  versions = version_entries.map { |x| x.fetch('metadata-version') }
  parseable_versions = versions.select { |version| gem_version_or_nil(version) }
  if parseable_versions.empty?
    warn "Skipping #{metadata_index}: no RubyGems-compatible metadata-version entries found"
    next
  end

  min_version = parseable_versions.min_by { |version| gem_version_or_nil(version) }
  entry = {
    "artifact" => artifact,
    "reachability_metadata_repo" => true,
    "minimum_version" => min_version,
    "metadata_locations" => [
      File.basename(metadata_index)
    ],
    "tests_locations" => [
      "https://github.com/oracle/graalvm-reachability-metadata/actions"
    ],
    "test_level" => "community-tested"
  }

  data[artifact] << entry
end

# Remove example library
data.delete('org.example:library')

File.open("_includes/native-image-tested-libraries-and-frameworks.html", "w") do |file|
  file.puts <<~HEADER
    <table class="tg libs-table" style="width:100%">
    <caption class="visually-hidden">Libraries and Frameworks Tested with Native Image</caption>
    <thead>
      <tr>
        <th class="tg name" style="width:60%" title="Artifact in the groupId:artifactId format" scope="col">Name</th>
        <th class="tg version" style="width:20%" title="Version" scope="col">Version</th>
        <th class="tg test-level" style="width:20%" title="Test Level" scope="col">Test Level</th>
      </tr>
    </thead>
    <tbody>
  HEADER

  data.sort_by(&:first).each do |artifact, entries|
    file.puts '<tr>'
    description = entries.find { |entry| entry["description"] }&.description
    file.puts %{<td class="tg artifact" rowspan="#{entries.size}"><code title="#{description}">#{artifact}</code></td>}

    sortable_entries, unsortable_entries = entries.partition { |entry| gem_version_or_nil(entry.minimum_version) }
    entries = sortable_entries.sort_by { |entry| gem_version_or_nil(entry.minimum_version) }.reverse + unsortable_entries

    entries.each_with_index { |entry, i|
      next unless %w[fully-tested community-tested].include?(entry.test_level)

      d = entry
      file.puts '<tr>' unless i == 0

      min_version = %{<a href="https://search.maven.org/artifact/#{artifact.sub(':', '/')}/#{d.minimum_version}/jar" target="_blank" title="Minimum version">#{d.minimum_version}</a>}
      max_version = d["maximum_version"]
      unless max_version
        if i > 0 and prev_entry = entries[i-1]
          max_version = prev_entry.minimum_version
        end
      end
      file.puts '<td class="tg">'
      file.puts %{⩾ #{min_version}#{", < #{max_version}" if max_version}}
      file.puts '</td>'

      footnote = entry['reachability_metadata_repo'] ? '<sup><a href="#footnote-1">1)</a></sup>' : ''
      test_level = case d.test_level
                   when "fully-tested" then "&#x2605;&#x2605;"
                   when "community-tested" then "&#x2605;#{footnote}"
                   else "&#x26AA;"
                   end

      title = case d.test_level
              when "fully-tested" then "The library or framework is continuously tested by the maintainers. This is the best test level."
              when "community-tested" then "The library or framework is continuously tested as part of the GraalVM Reachability Metadata repository or some other community-driven project."
              else "The library or framework is not tested continuously but may work in your application."
              end

      file.puts %{<td class="tg test-level"><span class="details" title="#{title}">#{test_level}</span></td>}

      file.puts '</tr>' unless i == 0
    }

    file.puts '</tr>'
  end
  file.puts '</tbody>'
  file.puts '</table>'
end
