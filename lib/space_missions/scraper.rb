class SpaceMissions::Scraper



  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = @@doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').to_s.gsub("http", "https")
      mission.full_name = @@doc.css('h1.media_feature_title').text.strip
      #binding.pry
    end

  end

  def self.get_attributes
      SpaceMissions::Mission.all.each do |mission|
      doc = Nokogiri::HTML(open(mission.url))
      mission.description = doc.css('div.wysiwyg_content p').text.delete("\r").gsub("\n\n", "\n")
      attributes = doc.css('ul.fast_facts li').text.delete("\t").delete("\n").gsub("\r", "  ").split("  ")

      attributes.each do |el|
        key = el.split(":")[0].downcase.gsub(" ","_")
        value = el.split(":")[1]
        mission.send("#{key}=",value)
      end
    end
    binding.pry
  end


  def self.mission_links
    @@mission_links
  end

  def self.doc
    @@doc
  end

end
