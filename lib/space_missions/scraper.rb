class SpaceMissions::Scraper

  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/?type=current"))
    slides = @@doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').value.gsub("http", "https")
      mission.description = slide.css('div.item_tease_overlay').text
    end
  end

  def self.get_attributes
    SpaceMissions::Mission.all.each do |mission|
      doc = Nokogiri::HTML(open(mission.url))
      mission.name = doc.css('.media_feature_title').text.strip

      #from fast_facts box
      attributes = doc.css('ul.fast_facts li')
      attributes.each do |el|
        key = el.children.children.text.split(":")[0].downcase.gsub(" ", "_")
        value = el.children.children.text.split(":")[1].delete("\r").delete("\n").strip
        mission.send("#{key}=", value)
      end
      mission
    end
  end


  def self.mission_links
    @@mission_links
  end


  def self.doc
    @@doc
  end

end
