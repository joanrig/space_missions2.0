class SpaceMissions::Mission
  attr_accessor  :acronym, :altitude, :attributes, :current_location, :description, :destinations, :end_date, :info, :landing_date, :launch_date, :launch_location, :mission_end_date, :name, :number, :status, :targets, :type, :url

  @@all = [] #all missions
  @@targets = []

  def initialize
    @@all << self
  end

  #i would like to be able to set up targets as their own objects that collab. with missions
  #so missions can have many targets and vice versa

  def self.set_targets
    puts "hello from Mission.set_targets"
    @targets = []<< @targets if @targets.is_a? String
    if @targets
      @targets.each do |target| #handles strings with either one or many targets
        target = SpaceMissions::Target.find_or_create_by_name(target)
        @@targets << target
        SpaceMissions::Target.missions << self
        binding.pry
      end
    end
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
