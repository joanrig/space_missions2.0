#require 'pry'
#SpaceMissions::Mission.get_JPL_mission_links
class SpaceMissions::Mission
  attr_accessor :name, :full_name, :url, :description, :type, :status, :launch_date, :launch_location, :end_date, :target, :current_location, :events, :key_discoveries, :scientific_instruments, :mission_links

  @@all = [] #array of all missions

  def self.get_JPL_mission_links
    @mission_links = []
    doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/"))
    slides = doc.css('ul.articles li.slide')
    slides.each do |slide|
      mission_links<< slide.css('a').attribute('href').to_s
    end
    @mission_links
  end

  def scrape_mission_links
    #@mission_pages = []
    # @mission_links.each do link
    #   doc = Nokogiri::HTML(open(link))#doesn't work - redirection forbidden?
    #   @mission_pages << doc
    # end

    #@mission_pages.each do |doc|
    # full_name = doc.css('h1.media_feature_title').text.strip
    # description = doc.css('div.wysiwyg_content p').text.strip
      #etc

  #example
    html = open("https://www.jpl.nasa.gov/missions/active-cavity-irradiance-monitor-satellite-acrimsat/")
    doc = Nokogiri::HTML(html)

    full_name = doc.css('h1.media_feature_title').text.strip
    description = doc.css('div.wysiwyg_content p').text.strip#needs formatting
    # mission_events =
    # key_discoveies =
    # scientific_instruments = [] ...
    fact_hash = doc.css('ul.fast_facts li').text.delete("\t").delete("\n").delete("\r").split("  ")
       #    => ["Acronym: AcrimSat",
       # "Type: Orbiter",
       # "Status: Past",
       # "Launch Date: December 20, 1999",
       # "Launch Location: Vandenberg Air Force Base, California",
       # "Mission End Date: August 08, 2014",
       # "Target: Earth",
       # "Current Location: Earth OrbitAltitude: 713 km (apogee), 672 km (perigee)"]

    end

    #after fact_box is reformatted, iterate through attributes, assign to object

    #go to jpl https://www.jpl.nasa.gov/missions/
    #create mission object from name, full name and url
    #scrape url for all other attributes
    # mission1 = self.new
    # #scrape JPL
    # mission_1.name = "AcrimSat"
    # mission_1.full_name = "Active Cavity Irradiance Monitor Satellite"
    # mission_1.url = "https://www.jpl.nasa.gov/missions/active-cavity-irradiance-monitor-satellite-acrimsat/"
    # #from url
    # mission_1.description = "The Active Cavity Irradiance Monitor Satellite, or AcrimSat, mission spent 14 years in orbit monitoring Earth's main energy source, radiation from the sun, and its impacts on our planet. The satellite's ACRIM 3 instrument was the third in a series of satellite experiments that have contributed to a critical data set for understanding Earth's climate: a 36-year, continuous satellite record of variations in total solar radiation reaching Earth, or total solar irradiance. Solar irradience creates winds, heats the land and drives ocean currents, and therefore contains significant data that climatologists can use to improve predictions of climate change and global warming.
    #
    # Launched on Dec. 21, 1999, for a planned five-year mission, AcrimSat went silent on Dec. 14, 2013. Attempts since then to reestablish contact have been unsuccessful. The venerable satellite most likely suffered an expected, age-related battery failure."
    #
    # mission_1.type = "Orbiter"
    # mission_1.status = "Past"
    # mission_1.launch_date = "Dec 20, 1999"
    # mission_1.launch_location = "Vandenberg Air Force Base, California"
    # mission_1.end_date = "August 08, 2014"
    # mission_1.target = "Earth"
    # mission_1.current_location = "Earth Orbit Altitude: 713 km (apogee), 672 km (perigee)"
    # mission1.events = "2005: AcrimSat completes its five-year primary mission and begins operating under its extended mission.
    #
    # Dec. 14, 2013: AcrimSat goes silent and attempts to reestablish contact are unsuccessful. The loss of contact is likely due to an expected, age-related battery failure. The mission officially came to an end on Aug. 8, 2014."
    #
    # mission_1.key_discoveries = "Data from the mission helped researchers formulate global climate models and study solar physics."
    #
    # mission_1.scientific_instruments = ["Active Cavity Irradiance Monitor 3 (ACRIM 3)"]
    # @@all << self
    #
    # mission_2 = self.new
    # mission_2.name = "ASTER"
    # mission_2.full_name = "Advanced Spaceborne Thermal Emission and Reflection Radiometer"
    # mission_2.url = "https://www.jpl.nasa.gov/missions/advanced-spaceborne-thermal-emission-and-reflection-radiometer-aster/"
    # @@all << self
    #
    # @@all



  def self.all
    @@all
  end



end
