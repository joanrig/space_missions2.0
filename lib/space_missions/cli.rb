class SpaceMissions::CLI
  attr_accessor :target, :list, :missions_by_target

  def call
    get_data
    new_search
    user_says
  end

  def get_data
    puts "Welcome to JPL's Space Missions!"
    SpaceMissions::Scraper.new.get_mission_links
    puts "\n... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    sleep(2)
    puts "Give us just a few more seconds to search the universe ..."
    puts ""
    sleep(2)
    puts "It's a big universe ... Try naming the planets in reverse order while you wait ..."
    puts "We'll be done before you can say 'Mars!'"
    SpaceMissions::Scraper.new.get_attributes
  end

#*******************   get/list missions methods ***************

  def new_search
    puts ""
    puts "Which set of JPL's missions would you like to explore?"
    puts "Try one of these:"
    puts ""
    puts "Past"
    puts "Current"
    puts "Future"
    puts "Proposed"
    puts "All"
    puts ""
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if ["past", "current", "future", "proposed"].include?(input)
        list = SpaceMissions::Mission.send("find_by_status", input)
        display_missions(list)
      elsif
        input == 'all'
        list = SpaceMissions::Mission.all
        display_missions(list)
      else
        puts ""
        puts "I didn't understand that. Please try again."
        puts ""
        new_search
      end
    end
  end

  def display_missions(list)
    @list = list
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

  def show_info(mission)
    puts ""
    puts "Fast facts about #{mission.name}:"
    puts ""
    puts "Acronym: #{mission.acronym}" if mission.acronym
    puts "Status: #{mission.status}" if mission.status
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

    puts "Would you like to visit this mission\'s website? Type 'Yes' or 'No'"
    puts "You can also type 'commands' for more options, or 'exit'"
    puts ""
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.capitalize == 'Yes'
        mission.open_in_browser
        choice
      elsif input == 'exit'
        goodbye
      else
        "Hmm .. not sure what you meant."
        new_search
      end
    end
    commands
  end

#*************************   user interface ********************

  def user_says(input=nil)
    while input != "exit"
      input = gets.strip.downcase
      select_mission(input)

      case input
      when "status"
        status
      when "commands"
        commands
      when "target"
        target
      when "launch"
        launched_when
      when "description"
        description
      when "new"
        new_search
      when "exit"
        goodbye
      else
        puts ""
        puts "Whoops! That's not a valid command."
        puts ""
        commands
      end#case
    end#while
  end

  def choice
    puts ""
    puts "Enter the number of a mission you'd like to learn more about."
    puts "You can also type 'commands' for more options, or 'exit' to quit this program'"
    puts ""
    user_says
  end

  def commands
    puts ""
    puts "Enter the number of a mission you'd like to learn more about."
    puts "other options:"
    puts ""
    puts "'target' => search missions by target (planet, universe, etc.)"
    puts "'launch' => search missions by launch date"
    puts "'description' => search missions by mission description"
    puts "'new' => start a new search"
    puts "'exit' => exit program"
    puts ""
    puts "What would you like to do?"
    puts ""
    user_says
  end

#********search by target or description & helper methods******

  def target
    puts ""
    puts "For a list of missions by target, enter target:"
    puts "Examples: 'Earth,' 'Mars', 'Universe', 'moon' etc."
    puts ""
    process_input("find_by_target")
  end

  def description
    puts ""
    puts "To search missions by their descriptions, enter a word or phrase."
    puts "Examples: 'rover,' 'spectrometer', 'climate', etc."
    puts ""
    process_input("find_by_description")
  end

  def status
    puts ""
    puts "To search missions by status, enter a word or phrase."
    puts "Examples: 'past', 'current', 'future' "
    puts ""
    process_input("find_by_status")
  end

  def process_input(method)
    input = nil
    while input != "exit"
      input = gets.strip
      @list = SpaceMissions::Mission.send(method, input)
      search_results
    end#while
  end

  def search_results
    if @list == []
      puts ""
      puts "Sorry, we couldn't find any missions matching your search."
      puts ""
      commands
    else
      @list = list
      display_missions(list)
    end
  end

  #**********   search by launch year & helper methods********

  def launched_when
    @input = nil
    while @input != "exit"
      puts ""
      puts "Tell us which way you'd like to search:"
      puts ""
      puts "Examples:"
      puts "'after 2005' => missions launched after Dec. 31, 2004"
      puts "'before 1980' => missions launched before Jan. 1, 1981"
      puts "'between' => to search missions launched during a range of years"
      puts ""

      @input = gets.strip.split
      if !["before", "after", "between"].include?(@input[0])
        puts ""
        puts "Sorry, I didn't understand that."
        puts ""
        commands
      else
        launched_before_or_after
        launched_between
      end
    end#while
  end

  def launched_before_or_after
    if @input[1].to_i > 999 && @input[1].to_i < 9999
      if ["before", "after"].include?(@input[0].downcase)
        parameter = @input[0]
        year = @input[1]
        @list = SpaceMissions::Mission.launched(parameter, year)
        search_results
      else
        puts ""
        puts "That's not a valid year."
        puts ""
        commands
      end
    end
  end

  def launched_between
    if "between" == @input[0].downcase
      while @input != "exit"
        puts ""
        puts "Please enter the range of years you\'d like to search."
        puts ""
        puts "Example:"
        puts "'2004 to 2009' => all missions that launched during the years 2005-2008."
        puts ""

        years = gets.strip.split("to")
        start_year = years[0].to_i
        end_year = years[1].to_i

        if start_year < end_year
          @list = SpaceMissions::Mission.launched("between", start_year, end_year)
          search_results
        else
          puts ""
          puts "Your starting year should come before your ending year."
          puts ""
          commands
        end
      end#2nd while
    end
  end

  #********************************************************

  def goodbye
    puts "Thanks for visiting! Please come back soon!"
    exit
  end



end
