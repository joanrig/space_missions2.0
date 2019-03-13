class SpaceMissions::CLI
  attr_accessor :target, :list, :missions_by_target

  def call
    get_data
    list_all_missions
    user_says
    goodbye
  end

  def get_data
    SpaceMissions::Scraper.new.get_jpl_mission_links
    puts "\n... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    sleep(2)
    puts "Give us just a few more seconds to search the universe ..."
    SpaceMissions::Scraper.new.get_attributes
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
    choice
  end

  def select_mission(input)
    if input.to_i > 0
      mission = @list[input.to_i - 1]
      if mission
        show_info(mission)
      else
        puts "That's not a mission number. Please check your reading glasses ;) and try again."
        sleep(2)
        display_missions
      end
    end
  end

  def user_says(input=nil)
    while input != "exit"
      input = gets.strip.downcase
      select_mission(input)

      case input
      when "list"
        list_all_missions
      when "commands"
        commands
      when "target"
        target
      when "launch"
        launched_when
      when "description"
        description
      when "exit"
        goodbye
      else
        puts "Whoops! That's not a valid command."
        commands
      end#case
    end#while
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
    puts "'launch' => search missions by launch date"
    puts "'description' => search missions by mission description"
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
    puts "Target/s: #{mission.targets}" if mission.targets
    puts "Destination/s: #{mission.destinations}" if mission.destinations
    puts "Current Location: #{mission.current_location}" if mission.current_location
    puts "Altitude: #{mission.altitude}" if mission.altitude
    puts "Mission web site: #{mission.url}"
    puts ""
    commands
  end

  def target
    puts "For a list of missions by target, enter target:"
    puts "Examples: 'Earth,' 'Mars', 'Universe', 'moon' etc."
    process_input("find_by_target")
  end

  def description
    puts "To search missions by their descriptions, enter a word or phrase."
    puts "Examples: 'rover,' 'spectrometer', 'climate', etc."
    process_input("find_by_description")
  end

  def launched_when
    input = nil
    while input != "exit"
      puts "Enter 'before' or 'after' and a year."
      puts "Examples:"
      puts "'after 2005' will return missions launched after Dec. 31, 2004."
      puts "'before 1980' will return missions launched before Jan. 1, 1981."

      input = gets.strip.split
      if input[1].to_i > 999 && input[1].to_i < 9999
        if ["before", "after"].include?(input[0].downcase)
          parameter = input[0]
          year = input[1]
          @list = SpaceMissions::Mission.launched(parameter, year)
          #binding.pry
          search_results
        else
          puts "Please enter either 'before' or 'after' before you enter a year."
        end
      else
        puts "That's not a valid year."  #figure out how to let them guess again.
      end#1st if
    end#while
    commands
  end

#helper methods process_input & search_results
  def process_input(method)
    input = nil
    while input != "exit"
      input = gets.strip.capitalize
      @list = SpaceMissions::Mission.send(method, input)
      search_results
    end#while
  end

  def search_results
    if @list == []
      puts "\nSorry, we couldn't find any missions matching your search."
      commands
    else
      puts ""
      display_missions
    end
  end

  def goodbye
    puts "Thanks for visiting!"
    exit
  end
end
