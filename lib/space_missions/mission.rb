class SpaceMissions::Mission
  attr_accessor :name, :full_name, :url, :description, :type, :status, :launch_date, :launch_location, :end_date, :target, :current_location, :events, :key_discoveries, :scientific_instruments

  @@all = []

  def initialize
    mission = self.new
    mission.name = "AcrimSat"
    mission.full_name = "Active Cavity Irradiance Monitor Satellite"
    mission.url = "https://www.jpl.nasa.gov/missions/active-cavity-irradiance-monitor-satellite-acrimsat/"
    #from url
    mission.description = "The Active Cavity Irradiance Monitor Satellite, or AcrimSat, mission spent 14 years in orbit monitoring Earth's main energy source, radiation from the sun, and its impacts on our planet. The satellite's ACRIM 3 instrument was the third in a series of satellite experiments that have contributed to a critical data set for understanding Earth's climate: a 36-year, continuous satellite record of variations in total solar radiation reaching Earth, or total solar irradiance. Solar irradience creates winds, heats the land and drives ocean currents, and therefore contains significant data that climatologists can use to improve predictions of climate change and global warming.

    Launched on Dec. 21, 1999, for a planned five-year mission, AcrimSat went silent on Dec. 14, 2013. Attempts since then to reestablish contact have been unsuccessful. The venerable satellite most likely suffered an expected, age-related battery failure."

    mission.type = "Orbiter"
    mission.status = "Past"
    mission.launch_date = "Dec 20, 1999"
    mission.launch_location = "Vandenberg Air Force Base, California"
    mission.end_date = "August 08, 2014"
    mission.target = "Earth"
    mission.current_location = "Earth Orbit Altitude: 713 km (apogee), 672 km (perigee)"
    mission.events = "2005: AcrimSat completes its five-year primary mission and begins operating under its extended mission.

    Dec. 14, 2013: AcrimSat goes silent and attempts to reestablish contact are unsuccessful. The loss of contact is likely due to an expected, age-related battery failure. The mission officially came to an end on Aug. 8, 2014."

    mission.key_discoveries = "Data from the mission helped researchers formulate global climate models and study solar physics."

    mission.scientific_instruments = ["Active Cavity Irradiance Monitor 3 (ACRIM 3)"]
  end


  def self.all
    puts "hello from Mission.all"
    @@all
  end



end
