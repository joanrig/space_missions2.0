class SpaceMissions::Scraper
  attr_accessor :value, :key, :kv


  def self.get_jpl_mission_links #initializes new missions
    @doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/?type=current"))
    slides = @doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission = SpaceMissions::Mission.new
      mission.url = slide.css('a').attribute('href').value.gsub("http", "https")
      mission.description = slide.css('div.item_tease_overlay').text.gsub(/[\r]|[\n]/, "")
    end
  end


  #scrape attributes from slide links, add them to missions instantiated above
  def self.get_attributes
    SpaceMissions::Mission.all.each do |mission|
      #doc = Nokogiri::HTML(open('https://www.jpl.nasa.gov/missions/voyager-1/'))
      doc = Nokogiri::HTML(open(mission.url))
      mission.name = doc.css('.media_feature_title').text.strip

      #from fast_facts box
      attributes = doc.css('ul.fast_facts li')
      attributes.each do |el|
        @el = el
        @kv = el.children.children.text.split(":")
        @key = @kv[0].downcase.gsub(" ", "_")
        set_values
        mission.send("#{@key}=", @value)
      end  #second do
    end #first do
  end

  def self.set_values
    if @key == "launch_date"#edge case: format dates that include times
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

  def self.mission_links
    @@mission_links
  end


end
