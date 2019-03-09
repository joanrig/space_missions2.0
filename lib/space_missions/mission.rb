class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :target, :type, :url

  @@all = [] #array of all missions

# can't set target here, mission is initialized in initial scrape, target is scraped in secondary scrape
  def initialize
    @@all << self
  end


  def self.set_target(target)#passing in value from scrape
   target = SpaceMissions::Target.find_or_create_by_name(name)
   @target = target
   SpaceMissions::Target.missions << self
  end


  def target=(target)
    @target = target
  end


  def self.find_by_target(input)
    missions = @@all.select {|mission| mission.target == input.capitalize}
    binding.pry
  end


  def self.all
    @@all
  end

end
