#CLI Controller

class SpaceMissions::CLI
  attr_accessor :mission

  def call
    puts "hello from cli.rb"
    list_missions
    menu
    goodbye
  end

  def list_missions
    puts "hello from #list_missions"
    #binding.pry
    SpaceMissions::Scraper.get_jpl_mission_links
    puts "just finished #get_jpl_mission_links"

    SpaceMissions::Scraper.get_attributes
    puts "just finished #get_attributes"

    puts "it's time for you to work on def initialize"

    SpaceMissions::Mission.new

    #SpaceMissions::Mission.description

    # puts "NASA JPL's Space Missions:"
    # @missions = SpaceMissions::Mission.all
    # @missions.each_with_index do |mission, index|
    #   puts "#{index+1}. #{mission.name} - #{mission.full_name}"
    #   #binding.pry
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      puts "Enter the number of the mission you'd like to learn more about. You can also type 'list' to see the missions again, or type 'exit' "

      if input.to_i > 0
        @mission = @missions[input.to_i-1]
      elsif input ==  "list"
        list_missions
      else
        puts "Whoops! That's not a number of a mission. Please try again."
      end
    end
  end

  def goodbye
    puts "Thanks for visiting!"
  end

end
