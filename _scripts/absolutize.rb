#!/usr/bin/env ruby

require 'uri'
require 'pathname'

abort "Usage: #{$0} FILE" unless ARGV.size == 1

file = ARGV.first
readme_link = "../../README.md" if file.include?("/reference-manual/ruby/") && !file.end_with?('README.md')
README_LINK = readme_link
FILE = File.expand_path(file)
FILE_DIR = Pathname(FILE).dirname
WEBSITE_ROOT = Pathname.pwd
IMAGE_TITLE = /(\s+".+?")$/

REPLACE_PREFIXES = {
  "https://github.com/oracle/graal/blob/master/docs/" => "docs/",
  "https://github.com/oracle/graal/blob/master/truffle/docs/" => "truffle/docs/",
  "https://github.com/oracle/graal/blob/master/espresso/docs/" => "espresso/docs/",
  "https://github.com/oracle/graal/blob/master/web-image/docs/" => "web-image/docs/"
}.freeze

# Older GraalVM releases link their language index to documentation that was
# maintained in separate public repositories and is intentionally not copied
# into this website source tree. Keep those links public and direct.
EXTERNAL_LANGUAGE_SOURCES = {
  "js/README.md" => "https://github.com/oracle/graaljs",
  "python/README.md" => "https://github.com/oracle/graalpython",
  "r/README.md" => "https://github.com/oracle/fastr",
  "ruby/README.md" => "https://github.com/truffleruby/truffleruby"
}.freeze

def base_url
  path = Pathname(FILE).relative_path_from(WEBSITE_ROOT).to_s
  url, = REPLACE_PREFIXES.find { |_, directory| path.start_with?(directory) }
  url || raise("Could not find base_url for #{path}")
end

def replace_links(line)
  line.gsub(/\[ ([^\]]+) \]\( ((?:\\\)|[^)])+) \)/x) do
    link_name, link = Regexp.last_match(1), Regexp.last_match(2)
    sanitized_link = link.sub(IMAGE_TITLE, '').gsub(/\\([()])/, '\\1')
    image_title = link[IMAGE_TITLE] || ''
    uri = URI(sanitized_link)

    if uri.scheme || uri.path.start_with?('/')
      prefix, in_website = REPLACE_PREFIXES.find { |candidate, _| link.start_with?(candidate) }
      if prefix
        target = WEBSITE_ROOT.join(link.sub(prefix, in_website))
        if File.exist?(URI(target.to_s).path)
          "[#{link_name}](#{target.relative_path_from(FILE_DIR)})"
        else
          warn "WARNING: Keeping #{link} because it is not included in the public website files"
          "[#{link_name}](#{link})"
        end
      else
        "[#{link_name}](#{link})"
      end
    elsif README_LINK && uri.path == README_LINK
      "[#{link_name}](#{link.sub(README_LINK, 'README.md')})"
    elsif File.exist?(File.expand_path(uri.path, File.dirname(FILE)))
      "[#{link_name}](#{link})"
    elsif (external_source = EXTERNAL_LANGUAGE_SOURCES[uri.path])
      "[#{link_name}](#{external_source})"
    elsif link.start_with?('..')
      url = URI.join(base_url, sanitized_link).to_s
      extension = url[/\.\w+$/]
      if %w[.jpg .png .svg .js .rb .py .u8 .md].include?(extension)
        url = url.sub('https://github.com/', 'https://raw.githubusercontent.com/').sub('/blob/', '/')
      end
      warn "WARNING: Replacing #{link} with GitHub URL because it is not in website files: #{url}"
      "[#{link_name}](#{url}#{image_title})"
    else
      abort "Broken link in #{FILE}: #{link}"
    end
  end
end

contents = File.read(FILE)
in_code_block = false
updated = contents.lines.map do |line|
  in_code_block = !in_code_block if line.match?(/\A\s*```/)
  in_code_block ? line : replace_links(line)
end.join
File.write(FILE, updated) if updated != contents
