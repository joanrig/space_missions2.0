class SpaceMissions::CLI
  attr_accessor :target, :list

  def call
    get_data
    list_missions
    user_says
    goodbye
  end

  def get_data
    SpaceMissions::Scraper.get_jpl_mission_links
    puts "... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    sleep(1)
    puts "Give us just a few more seconds to search the universe ..."
    SpaceMissions::Scraper.get_attributes
  end

  def list_missions
    @list = SpaceMissions::Mission.all
    i = 0
    @list.each.with_index(1) do |mission, index|
      if mission.acronym == nil
        puts "#{index}. #{mission.name}"
      else
        puts "#{index}. #{mission.acronym} - #{mission.name}"
        i+= 1
      end
    end
    choice
  end

  #try to switch to case statement
  def user_says(input=nil)
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0
        mission = SpaceMissions::Mission.all[input.to_i - 1]
        show_info(mission)
      elsif input ==  "list"
        list_missions
      elsif input == "commands"
        commands
      elsif input == "target"
        target
      elsif input == "exit"
        goodbye
      else
        puts "Whoops! That's not a valid command."
        commands
      end
    end
  end

  def choice
    puts ""
    puts "Enter the number of a mission you'd like to learn more about."
    puts "You can also type 'commands' for more options, or 'exit' to quit this program'"
    user_says
  end

  def commands
    puts "Please type a command:"
    puts ""
    puts "enter number of any mission you'd like to learn more about"
    puts "'list' => see the list of missions"
    puts "'target' => search missions by target (planet, universe, etc.)"
    puts "'type' => search missions by type (orbiter, lander, rover, instrumet, etc)"
    puts "'launch date' => search missions by launch year"
    puts "'end' => search missions by end of mission year"
    puts "'exit' => exit program"
    puts ""
    puts "What would you like to do?"
    puts ""
    puts ""
    user_says
  end

  # if you can move this out of user_says into its own method:
  # def get_info_by_number(input)
  #   if input.to_i > 0
  #     mission = SpaceMissions::Mission.all[input.to_i - 1]
  #   end
  # end

  def show_info(mission)
    #should i park this under mission.info in class Mission
    puts "Acronym: #{mission.acronym}" if mission.acronym
    puts "Description: #{mission.description}" if mission.description
    puts "Type: #{mission.type}" if mission.type
    puts "Launch Date: #{mission.launch_date}" if mission.launch_date
    puts "Launch Location #{mission.launch_location}" if mission.launch_location
    puts "Landing Date: #{mission.landing_date}" if mission.landing_date
    puts "End Date: #{mission.end_date}" if mission.end_date
    puts "Mission End Date: #{mission.mission_end_date}" if mission.mission_end_date
    puts "Target: #{mission.target}" if mission.target
    puts "Destination: #{mission.destination}" if mission.destination
    puts "Current Location: #{mission.current_location}" if mission.current_location
    puts "Altitude: #{mission.altitude}" if mission.altitude
    puts ""
    commands
  end


  def target
    puts "For a list of missions by planet or universe, enter planet name or 'universe'"
    input=nil
    while input != "exit"
      input = gets.strip.capitalize
      #binding.pry
      SpaceMissions::Mission.find_by_target(input).each.with_index(1) do |mission, index|
        puts "#{index}. #{mission.name}"
      end
      puts "pick the number of a mission for more info"
      # input=nil
      # while input != "exit"
      #   if input.to_i > 0
      #     mission = @targets[input.to_i - 1]
      #     show_info(mission)
      #   end
      # end #2nd while
  #   end #1st while
    end




  end

  def goodbye
    puts "Thanks for visiting!"
    exit
  end

end
