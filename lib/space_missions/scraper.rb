class SpaceMissions::Scraper
  attr_accessor :value, :key, :kv

  #scrape main page for mission links, initialize missions
  def self.get_jpl_mission_links
    @doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/?type=current"))
    slides = @doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').value.gsub("http", "https")
      mission.description = slide.css('div.item_tease_overlay').text.gsub(/[\r]|[\n]/, "")
    end
  end

  #scrape attributes from slide links, add to missions
  def self.get_attributes
    SpaceMissions::Mission.all.each do |mission|
      #doc = Nokogiri::HTML(open(mission.url))
      doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/mars-science-laboratory-curiosity-rover-msl/"))
      mission.name = doc.css('.media_feature_title').text.strip

      #from fast_facts box
      attributes = doc.css('ul.fast_facts li')
      attributes.each do |el|
        @el = el
        @kv = el.children.children.text.split(":")
        @key = @kv[0].downcase.gsub(" ", "_")
        format_keys_and_values
        mission.send("#{@key}=", @value)
      end  #second do
    end #first do
  end

  def self.format_keys_and_values#deals with edge cases for both keys and values
    if @key.include?("date")
      #binding.pry
      cal_date = @el.css("p").children[1].text.strip if @el
      time = @el.css("p").children[3].text.strip if @el.css("p").children[3]
      if time
        @value = "#{cal_date}, #{time}"
      else
        @value = "#{cal_date}"

      end
    else
      @value = @kv[1...(@kv.size)].map{|val| val.gsub(/[\r]|[\n]/, "").strip}.join(",")
    end

    if ["target", "destination"].include?(@key)
      @key = "#{@key}s"
    end
  end
end
