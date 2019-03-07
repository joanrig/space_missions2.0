class SpaceMissions::Scraper
  attr_accessor :doc, :url, :mission_links

  @@mission_links = []

  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = doc.css('ul.articles li.slide')
    slides.each do |slide|
      @url = slide.css('a').attribute('href').to_s.gsub("http", "https")
      @@mission_links << @url
    end
    @@mission_links#returns array of full web addresses
  end

  def mission_links
    @@mission_links
  end

end
