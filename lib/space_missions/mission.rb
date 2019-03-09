class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destination, :end_date,  :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :target, :type, :url

  @@all = [] #array of all missions

  def initialize
    @@all << self
  end

  def mission_number
    @@all.each_with_index do |mission, index|
      mission.number = index + 1
    end
  end

  def self.find_by_target(input)
    missions = @@all.select {|mission| mission.target == input.capitalize}
    #binding.pry
  end

  def self.number
    @@all.each_with_index do |mission, index|
    number = index + 1
    @mission.number = number
    binding.pry
    end
  end

  def self.find_by_end_type(input)
    missions = @@all.select {|mission| mission.type == input}
  end

  def self.find_by_launch_date(input)
    missions = @@all.select {|mission| mission.launch_date.split.last == input}
  end

  def self.find_by_end_date(input)
    missions = @@all.select {|mission| (mission.end_date || mission.mission.end.date).split.last == input}
  end

  def self.all
    @@all
  end

end
