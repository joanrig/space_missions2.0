class SpaceMissions::Scraper

  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = @@doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').to_s.gsub("http", "https")
      mission.name = @@doc.css('h1.media_feature_title').text.strip
    end
  end

  def self.get_attributes
      SpaceMissions::Mission.all.each do |mission|
      doc = Nokogiri::HTML(open(mission.url))

      #from text
      mission.description = doc.css('div.wysiwyg_content p').text.delete("\r").gsub("\n\n", "\n")
      attributes = doc.css('ul.fast_facts li').text.delete("\t").delete("\n").gsub("\r", "  ").split("  ")
      #still need mission events, key discoveries and array of scientific instruments
      #binding.pry

      #from fast_facts box
      #[1] pry(SpaceMissions::Scraper)> attributes
        # attributes=>
        #["Acronym: AcrimSat",
        #  "Type: Orbiter",
        #  "Status: Past",
        #  "Launch Date: December 20, 1999",
        #  "Launch Location: Vandenberg Air Force Base, California",
        #  "Mission End Date: August 08, 2014",
        #  "Target: Earth",
        #  "Current Location: Earth Orbit",
        #  "Altitude: 713 km (apogee), 672 km (perigee)"]
      attributes.each do |el|
        key = el.split(":")[0].downcase.gsub(" ","_")
        value = el.split(":")[1].strip
        # with .strip error =>/Users/Joan/Dev/space_missions/lib/space_missions/scraper.rb:22:in `block (2 levels) in get_attributes': undefined method `strip' for nil:NilClass (NoMethodError)
        #without .strip, error=> `_april_03,_2013=' (a value!) gets sent as key
        #if i make it: value = el.split(":")[1].strip if el.split(":")[1] ...then most values end up as nil
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
