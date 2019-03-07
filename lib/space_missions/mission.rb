class SpaceMissions::Mission
  attr_accessor :name, :full_name, :url, :description, :type, :status, :launch_date, :launch_location, :end_date, :target, :current_location, :events, :key_discoveries, :scientific_instruments, :mission_links

  @@all = [] #array of all missions

  def self.get_jpl_mission_links
    @mission_links = []
    doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = doc.css('ul.articles li.slide')
    binding.pry
    slides.each do |slide|
      @mission_links<< slide.css('a').attribute('href').to_s
    end
    @mission_links
  end

  def scrape_mission_links
    @mission_links.slice(3).each do |link|
      doc = Nokogiri::HTML(open(link))
      self.full_name = doc.css('h1.media_feature_title').text.strip
      self.description = doc.css('div.wysiwyg_content p').text.strip#needs-formatting
      sets = doc.css('ul.fast_facts li').text.delete("\t").delete("\n").delete("\r").split("  ")
      binding.pry
    end
  end


  def self.all
    @@all
  end



end
