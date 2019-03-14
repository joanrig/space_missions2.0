class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destinations, :end_date, :info, :landing_date, :launch_date, :launch_location, :launch_year, :mission_end_date, :name, :number, :status, :targets, :type, :url

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

  # def self.launched_since(input)#year
  #   missions = @@all.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i > input.to_i}
  # end

  def self.launched(parameter, year, end_year=nil)
    if parameter == "after"
      missions = @@all.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i > year.to_i}      
    elsif parameter == "before"
        missions = @@all.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i < year.to_i}
    elsif parameter == "between"
      later = missions = @@all.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i > year}
      before = missions = @@all.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i < end_year}
      missions = before & later
    end

  end

  def self.all
    @@all
  end

end
