class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :status, :target, :type, :url

  @@all = [] #array of all missions

  def initialize
    @@all << self
  end


  def self.target(input)
    array = self.all.select{|mission| mission[:target] == "#{target}".map{|y| y[:name]}}
    binding.pry
  end


  def self.all
    @@all
  end

end
