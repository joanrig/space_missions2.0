class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destinations, :end_date, :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :targets, :type, :url

  @@all = [] #all missions

  def initialize
    @@all << self
  end

  def self.find_by_target(input)
    missions = @@all.select {|mission| mission.targets.include?(input.capitalize) if mission.targets}
  end

  def self.find_by_description(input)
    missions = @@all.select {|mission| mission.description.downcase.include?(input.downcase) if mission.description}
  end

  




  def self.all
    @@all
  end

end
