#!/usr/bin/env ruby

require 'yaml'

options = { add_title: false, add_latest_canonical_url: false, add_versioned_redirects: false, add_version_to_permalinks: false }
folders = []
ARGV.each do |argument|
  case argument
  when '--add-title' then options[:add_title] = true
  when '--add-latest-canonical-url' then options[:add_latest_canonical_url] = true
  when '--add-versioned-redirects' then options[:add_versioned_redirects] = true
  when '--add-version-to-permalinks' then options[:add_version_to_permalinks] = true
  when /^-/ then raise "Unknown option: #{argument}"
  else folders << argument
  end
end

folders.each do |folder|
  Dir.glob("#{folder}/**/*.md") do |file|
    lines = File.readlines(file)
    next warn("No YAML header in #{file} !") unless lines.first&.strip == '---'
    closing = lines.drop(1).index { |line| line.strip == '---' }
    next warn("No YAML header in #{file} !") unless closing

    header = YAML.load(lines[1..closing].join)
    next warn("Unexpected YAML header in #{file}: #{header.inspect}") unless header.is_a?(Hash)
    body = lines[(closing + 2)..].join
    next if %w[redirected docs_landing].include?(header['layout'])

    if options[:add_title] && !header.key?('title')
      header['title'] = body[/^##?\s+(\S.+)$/, 1] || header['link_title']
      warn "Could not find title in #{file}" unless header['title']
    end

    if (permalink = header['permalink'])
      header['canonical_url'] = "/latest#{permalink}" if options[:add_latest_canonical_url]
      if options[:add_version_to_permalinks] && !permalink.start_with?('/$version')
        redirects = Array(header['redirect_from'])
        header['permalink'] = "/$version#{permalink}"
        redirects << permalink
        redirects.concat(redirects.map { |url| "/$version#{url}" }) if options[:add_versioned_redirects]
        header['redirect_from'] = redirects.uniq.reject { |url| url == header['permalink'] }
      end
    end
    File.write(file, "#{YAML.dump(header).chomp}\n---\n#{body}")
  end
end
