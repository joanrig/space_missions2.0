class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destinations, :end_date, :info, :landing_date, :launch_date, :launch_location, :launch_year, :mission_end_date, :missions_by_status, :name, :number, :status, :targets, :type, :url

  @@all = [] #all missions


  def initialize
    @@all << self
  end


  def self.find_by_target(input)
    missions = @missions_by_status.select {|mission| mission.targets.include?(input.capitalize) if mission.targets}
  end

  def self.find_by_description(input)
    missions = @missions_by_status.select {|mission| mission.description.downcase.include?(input.downcase) if mission.description}
  end

  def self.find_by_status(input)
    @missions_by_status = @@all if input.downcase == "all"
    @missions_by_status = @@all.select {|mission| mission.status == input.capitalize if mission.status}
  end

  def self.launched(parameter, year, end_year=nil)
    if parameter == "after"
      missions = @missions_by_status.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i > year.to_i}

    elsif parameter == "before"
      #does not catch launch_date TBD
        @missions_by_status.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i < year.to_i}

    elsif parameter == "between"
      later =  @missions_by_status.select {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i > year}
      before = @missions_by_status {|mission| mission.launch_date.scan(/\d{4}/)[0].to_i < end_year}
      missions = before & later
    end
  end

  def open_in_browser
    system("open '#{url}'")
  end

  def self.all
    @@all
  end


end
