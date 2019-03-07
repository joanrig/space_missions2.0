class SpaceMissions::Scraper

  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = @@doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').to_s.gsub("http", "https")
      mission.name = @@doc.css('h1.media_feature_title').text.strip
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
        value = el.split(":")[1].strip
        # with .strip /Users/Joan/Dev/space_missions/lib/space_missions/scraper.rb:22:in `block (2 levels) in get_attributes': undefined method `strip' for nil:NilClass (NoMethodError)
        #without .strip, `_april_03,_2013=' gets sent as key
        mission.send("#{key}=", value)
      end
      mission
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
