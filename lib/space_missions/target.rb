class SpaceMissions::Target
  attr_accessor :name, :target

  def initialize(name)
    @name = name
    @targets = target
    @@missions = [] #target has many missions; missions can have multiple tagets
    @@all << self
    binding.pry
  end

  def self.find_or_create_by_name(name)
    @all.find{|target| target.name = name} || self.new(name)
  end

  def all
    @@all
  end

end
