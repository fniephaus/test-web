require 'liquid'

module Jekyll
  module CapitalizeAll
    def capitalize_all(words)
      words.split('-').map(&:capitalize).join(' ')
    end
  end
end

Liquid::Template.register_filter(Jekyll::CapitalizeAll)
