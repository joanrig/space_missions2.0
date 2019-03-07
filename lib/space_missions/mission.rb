class SpaceMissions::Mission
  attr_accessor :url, :acronym, :full_name, :describe, :attributes, :type, :status, :launch_date, :launch_location, :end_date, :target, :current_location, :altitude, :scientific_instruments

  @@all = [] #array of all missions

  def initialize
    binding.pry
    @name = @@doc.css('h1.media_feature_title').text.strip
    @describe = @doc.css('div.wysiwyg_content p').text.delete("\r").gsub("\n\n", "\n")
    binding.pry
    @attributes.each do |key,value|
      self.send("#{key.to_s}=",value)
    end
    @@all << self
  end



  def self.get_attributes
    SpaceMissions::Scraper.mission_links[0..4].each do |link|
      @doc = Nokogiri::HTML(open(link))
      @attributes = @doc.css('ul.fast_facts li').text.delete("\t").delete("\n").gsub("\r", "  ").split("  ")
      #binding.pry
    end
  end

  def self.description
    puts @describe
    #binding.pry
  end


  def self.all
    @@all
  end



end
