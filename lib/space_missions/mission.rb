class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :status, :target, :type, :url

  @@all = [] #array of all missions

  def initialize
    @@all << self
  end

  def self.info
    puts "#{mission.name}:"
    puts "Acronym: #{mission.acronym}" if mission.acronym
    puts "Description: #{mission.description}" if mission.description
    puts "Type: #{mission.type}" if mission.type
    puts "Launch Date: #{mission.launch_date}" if mission.launch_date
    puts "Launch Location: #{mission.launch_location}" if mission.launch_location
    puts "Landing Date: #{mission.landing_date}" if mission.landing_date
    puts "End Date: #{mission.end_date}" if mission.end_date
    puts "Mission End Date: #{mission.mission_end_date}" if mission.mission_end_date
    puts "Target of interest: #{mission.target}" if mission.target
    puts "Destination: #{mission.destination}" if mission.destination
    puts "Current Loction: #{mission.current_location}" if mission.current_location
    puts "Altitude: #{mission.altitude}" if mission.altitude
  end

  def self.find()
    self.all.select{|mission| mission[:target] == "#{target}".map{|y| y[:name]}}
    #binding.pry
  end


  def self.all
    @@all
  end

end
