class SpaceMissions::CLI
  attr_accessor :target, :list, :missions_by_target

  def call
    get_data
    list_all_missions
    user_says
    goodbye
  end

  def get_data
    SpaceMissions::Scraper.get_jpl_mission_links
    puts "\n... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    sleep(2)
    puts "Give us just a few more seconds to search the universe ..."
    SpaceMissions::Scraper.get_attributes
  end

  def list_all_missions
    @list = SpaceMissions::Mission.all
    display_missions
  end

  def display_missions
    @list.each.with_index(1) do |mission, index|
      if mission.acronym == nil
        puts "#{index}. #{mission.name}"
      else
        puts "#{index}. #{mission.acronym} - #{mission.name}"
      end
    end

    puts "\nEnter the number of the mission you'd like to learn more about."
    input = gets.strip
    if input.to_i > 0
      select_mission
    else
      "Sorry, that number is not on the list."
      commands
    end
  end

  def select_mission(input=nil)
    mission = @list[input.to_i - 1]
    show_info(mission)
  end

  def user_says(input=nil)
  while input != "exit"
    input = gets.strip.downcase
    if input.to_i > 0
      select_mission
    end

    case input
    when "list"
      list_all_missions
    when "commands"
      commands
    when "target"
      target
    when "exit" || "exit!"
      goodbye
    else
      puts "Whoops! That's not a valid command."
      commands
    end
  end
  end

  def choice
    puts "\nEnter the number of a mission you'd like to learn more about."
    puts "You can also type 'commands' for more options, or 'exit' to quit this program'"
    user_says
  end

  def commands
    puts "\nPlease type a command:"
    puts "\nEnter the number of a mission you'd like to learn more about"
    puts "'list' => to see the list of all missions"
    puts "'target' => search missions by target (planet, universe, etc.)"
    puts "'exit' => exit program"
    puts "\nWhat would you like to do?\n"
    user_says
  end

  def show_info(mission)
    puts "\nFast facts about #{mission.name}:"
    puts "\nAcronym: #{mission.acronym}" if mission.acronym
    puts "Description: #{mission.description}" #if mission.description
    puts "Type: #{mission.type}" if mission.type
    puts "Launch Date: #{mission.launch_date}" if mission.launch_date
    puts "Launch Location: #{mission.launch_location}" if mission.launch_location
    puts "Landing Date: #{mission.landing_date}" if mission.landing_date
    puts "End Date: #{mission.end_date}" if mission.end_date
    puts "Mission End Date: #{mission.mission_end_date}" if mission.mission_end_date
    puts "Target/s: #{mission.targets.join(", ")}" if mission.targets
    puts "Destination/s: #{mission.destinations.join(", ")}" if mission.destinations
    puts "Current Location: #{mission.current_location}" if mission.current_location
    puts "Altitude: #{mission.altitude}" if mission.altitude
    puts "Mission web site: #{mission.url}"
    puts ""
    commands
  end

  def target
    puts "\nFor a list of missions by target, enter target:"
    puts "Examples: 'Earth,' 'Mars', 'Universe', 'moon' etc."
    input=nil
    while input != "exit"
      input = gets.strip.capitalize
      @list = SpaceMissions::Mission.find_by_target(input)
      if @list == []
        puts "\nSorry, we don't have any current missions for that target."
        commands
      else
        display_missions
      end#else
    end#while
  end

  def goodbye
    puts "Thanks for visiting!"
    exit
  end

end
