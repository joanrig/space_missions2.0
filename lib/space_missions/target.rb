class SpaceMissions::Target
  attr_accessor :name, :target

  def initialize(name)
    @name = name
    @target = target
    @@missions = [] #target has many missions; missions can have multiple tagets
    @@all << self
  end

  def self.find_or_create_by_name(name)
    @all.self.find{|target| target.name = name} || self.new(name)
  end

end
