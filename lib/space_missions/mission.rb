class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :target, :type, :url

  @@all = [] #array of all missions

# can't set targeet here, mission is initialized in in initial scrape, target is scraped in secondary scrape
  def initialize(name)
    @@all << self
  end

  def set_target(target)#passing in value from scrape
   target = SpaceMissions::Target.find_or_create_by_name(target) #=> object
   mission.target = target #set value of mission.target to new target object
   target.missions << mission
   end
 end

  def self.find_by_target(input)
    missions = @@all.select {|mission| mission.target == input.capitalize}
    #binding.pry
  end

  def self.find_by_end_type(input)
    missions = @@all.select {|mission| mission.type == input}
  end

  #futre featues
  # def self.find_by_launch_date(input)
  #   missions = @@all.select {|mission| mission.launch_date.split.last == input}
  # end
  #
  # def self.find_by_end_date(input)
  #   missions = @@all.select {|mission| (mission.end_date || mission.mission.end.date).split.last == input}
  end

  def self.all
    @@all
  end

end
