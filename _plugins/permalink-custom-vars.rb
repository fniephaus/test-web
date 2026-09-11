Jekyll::Hooks.register :site, :post_read do |site|
  version = site.config['version']
  next unless version

  site.pages.each do |page|
    if page.permalink
      page.data['permalink'] = page.data['permalink'].gsub('$version', version.to_s)
    end

    next unless page.data.include?('redirect_from')

    page.data['redirect_from'] = Array(page.data['redirect_from']).map do |url|
      url.gsub('$version', version.to_s)
    end
  end
end
