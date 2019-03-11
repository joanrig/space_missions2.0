class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destinations, :end_date, :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :targets, :type, :url

  @@all = [] #array of all missions
  #@@targets = []

  def initialize
    @@all << self
  end

  #i would like to be able to set up targets as their own objects that collab. with missions
  #so missions can have many targets and vice versa

  # def self.set_targets(targets)#passing in value from scraper
  #   targets.to_s.split(",").each do |target| #handles strings with one or many targets
  #     target = SpaceMissions::Target.find_or_create_by_name(name)
  #     @targets << targets
  #     SpaceMissions::Target.missions << self
  #   end
  # end


  # #this method does not take into account multiple targets for same mission. i tried
  # missions = @@all.select {|mission| mission.targets == (input.capitalize) if mission.targets} if #input // but that did not work
  
  def self.find_by_target(input)
    missions = @@all.select {|mission| mission.targets == (input.capitalize) if mission.targets} if input
  end


  def self.all
    @@all
  end
end
