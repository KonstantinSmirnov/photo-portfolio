xml.instruct!
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url
    xml.lastmod Time.now - (2 * 7 * 24 * 60 * 60)
    xml.changefreq 'monthly'
    xml.priority '0.5'
  end
  unless @contact_page.nil?
    xml.url do
      xml.loc contact_url
      xml.lastmod @contact_page.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'monthly'
      xml.priority '0.5'
    end
  end
  unless @portfolio_page.nil?
    xml.url do
      xml.loc categories_url
      xml.lastmod Time.now - (2 * 7 * 24 * 60 * 60)
      xml.changefreq 'monthly'
      xml.priority '0.5'
    end
  end
  @projects.each do |project|
    xml.url do
      xml.loc project_url(project)
      xml.lastmod project.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end
end
