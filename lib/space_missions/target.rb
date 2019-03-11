class SpaceMissions::Target
  attr_accessor :name, :target, :missions

  @@missions = [] #target has many missions; missions can have multiple tagets

#nothing in this class is currently being used.
  def initialize(name)
    @name = name
    @@all << self
  end

  def self.find_or_create_by_name(name)
    @@all.find{|target| target.name = name} || self.new(name)
  end

  def all
    @@all
  end

  def self.missions
    @@missions
  end


end
