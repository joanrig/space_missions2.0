class SpaceMissions::Mission
  attr_accessor :url, :acronym, :name, :full_name, :description, :attributes, :type, :status, :launch_date, :launch_location, :end_date, :target, :current_location, :altitude, :scientific_instruments

  @@all = [] #array of all missions

  def initialize
    @@all << self
  end









  def self.all
    @@all
  end



end
