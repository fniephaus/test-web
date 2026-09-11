#!/usr/bin/env ruby

require 'rexml/document'

abort "Usage: #{$0} target-sitemap.xml source-sitemap.xml URL-prefix" unless ARGV.size == 3
target_xml, source_xml, url_prefix = ARGV
target = REXML::Document.new(File.read(target_xml))
source = REXML::Document.new(File.read(source_xml))
urls = source.root.get_elements('url').select do |node|
  node.elements['loc']&.text&.start_with?(url_prefix)
end
abort "No <loc> tags found for #{url_prefix} in #{source_xml}" if urls.empty?
urls.each { |node| target.root.add_element(node.deep_clone) }
File.write(target_xml, target.to_s)
