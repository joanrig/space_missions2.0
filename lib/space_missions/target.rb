class
  attr_accessor :name, :mission

  def initialize(name)
    @name = name
    @missions = [] #target has many missions/ missions belong to gargets
    @@all << self
  end

  def self.find_or_by_create_by_name(name)
    @all.self.find{|target| target.name = name} || self.new(name)
  end

end




# class Mission
#   def initialize(name, target)
#     set_target(target)
#     save
#   end
#
#   def set_target (target)
#     target = Target.find_by_create_by_name(target)
#     mission.target = target
#     target.missions << self
#     end
#   end
