class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :status, :target, :type, :url,
  :data

  @@all = [] #array of all missions

  def initialize
    @@all << self
  end

  def self.target(target)
    self.select{|x| x[:target] == "#{SpaceMissions::CLI.target}".map{|y| y[:data]}}
  end


  def self.all
    @@all
  end

end
