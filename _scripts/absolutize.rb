#!/usr/bin/env ruby

require 'uri'
require 'pathname'

abort "Usage: #{$0} FILE" unless ARGV.size == 1

file, = ARGV

readme_link = nil
if file.include?("/reference-manual/ruby/") && !file.end_with?('README.md')
  readme_link = "../../README.md"
end
README_LINK = readme_link

FILE = File.expand_path(file)
FILE_DIR = Pathname(FILE).dirname
WEBSITE_ROOT = Pathname.pwd

contents = File.read(FILE)
original_contents = contents.dup

SHOWN_FILE = Mutex.new
def log(message)
  unless SHOWN_FILE.locked?
    puts "In #{FILE}"
    SHOWN_FILE.lock
  end
  puts message
end

IMAGE_TITLE = /(\s+".+?")$/

REPLACE_PREFIXES = {
  "https://github.com/oracle/graaljs/blob/master/docs/user/" => "docs/reference-manual/js/",
  "https://github.com/oracle/graalpython/blob/master/docs/user/" => "docs/reference-manual/python/",
  "https://github.com/oracle/fastr/blob/master/documentation/user/" => "docs/reference-manual/r/",
  "https://github.com/oracle/truffleruby/blob/master/doc/user/" => "docs/reference-manual/ruby/",
  "https://github.com/oracle/graal/blob/master/docs/" => "docs/",
  "https://github.com/oracle/graal/blob/master/truffle/docs/" => "truffle/docs/",
}

def base_url
  path = Pathname(FILE).relative_path_from(WEBSITE_ROOT).to_s
  url, _ = REPLACE_PREFIXES.find { |_, dir| path.start_with?(dir) }
  url or raise "Could not find base_url for #{path}"
end

def replace_links(line)
  line.gsub(/\[ ([^\]]+) \]\( ((?:\\\)|[^)])+) \)/x) do
    link_name, link = $1, $2

    sanitized_link = link
    if sanitized_link =~ IMAGE_TITLE
      image_title = $1
      sanitized_link = sanitized_link.sub(IMAGE_TITLE, '') # ![alt text](image.png "image title")
    else
      image_title = ''
    end
    sanitized_link = sanitized_link.gsub(/\\([()])/, '\1') # unescape \( and \)

    uri = URI(sanitized_link)
    if uri.scheme or uri.path.start_with?('/') # absolute link
      prefix, in_website = REPLACE_PREFIXES.find { |prefix, _| link.start_with?(prefix) }
      if prefix
        target_file = WEBSITE_ROOT.join(link.sub(prefix, in_website))
        unless File.exist?(URI(target_file.to_s).path)
          log "The link [#{link_name}](#{link}) -> #{target_file} is broken\nIn line #{line}\n\n"
          abort
        end
        relative_link = target_file.relative_path_from(FILE_DIR)
        log "Replacing #{link} with #{relative_link}"
        "[#{link_name}](#{relative_link})"
      else
        "[#{link_name}](#{link})"
      end
    elsif README_LINK and uri.path == README_LINK
      website_index = link.sub(README_LINK, 'README.md') # '../')
      log "Replacing #{link} with #{website_index}"
      "[#{link_name}](#{website_index})"
    else
      resolved = File.expand_path(uri.path, File.dirname(FILE))
      log resolved if $VERBOSE

      if File.exist?(resolved)
        "[#{link_name}](#{link})"
      elsif link.start_with?('..') # link to above the user hierarchy, link to GitHub
        absolute_url = URI.join(base_url, sanitized_link).to_s
        ext = absolute_url[/\.\w+$/]
        is_image = %w[.jpg .png .svg].include?(ext)
        if is_image
          absolute_url = absolute_url.sub('https://github.com/', 'https://raw.githubusercontent.com/').sub('/blob/', '/')
        end

        if is_image
          log "Replacing image #{link} not in website files with GitHub URL: #{absolute_url}#{image_title}"
        else
          log "\nWARNING: Replacing #{link} with GitHub URL because it is not in website files: #{absolute_url}#{image_title}\n\n"
        end
        "[#{link_name}](#{absolute_url}#{image_title})"
      else
        log "The link [#{link_name}](#{link}) -> #{resolved} is broken\nIn line #{line}\n\n"
        abort
      end
    end
  end
end

lines = contents.lines
in_code_block = false
lines = lines.map do |line|
  in_code_block = !in_code_block if line =~ /\A\s*```/

  if in_code_block
    line
  else
    replace_links(line)
  end
end
contents = lines.join

if contents != original_contents
  File.write(FILE, contents)
end
