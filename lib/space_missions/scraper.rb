class SpaceMissions::Scraper
  attr_accessor :value


  def self.get_jpl_mission_links
    @@doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/?type=current"))
    slides = @@doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').value.gsub("http", "https")
      mission.description = slide.css('div.item_tease_overlay').text.gsub(/[\r]|[\n]/, "")
    end
  end


  #scrape attributes from slide links
  def self.get_attributes
    SpaceMissions::Mission.all.each do |mission|
      #doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/voyager-2/"))
      doc = Nokogiri::HTML(open(mission.url))
      mission.name = doc.css('.media_feature_title').text.strip

      #from fast_facts box
      attributes = doc.css('ul.fast_facts li')
      attributes.each do |el|
        a = el.children.children.text.split(":")
        key = a[0].downcase.gsub(" ", "_")
        @value = a[1...(a.size)].map{|val| val.gsub(/[\r]|[\n]/, "").strip}.join

        #if value has multiple values, send them to mission as array
        if (key == "target" || key == "destination")
          if @value.split(",").count > 1
            @value = @value.split(",")
          end
        end

        mission.send("#{key}=", @value)
      end  #second do
    end #first do
  end


  def self.mission_links
    @@mission_links
  end


  def self.doc
    @@doc
  end

end
