class SpaceMissions::CLI
  attr_accessor :target, :list, :missions_by_target


  def call
    welcome
    get_data
    new_search#=> pick by status => display missions => refine search => listen
  end

  def welcome
    puts"".center(80).on_white
    puts"".center(80).on_white
    puts"".center(80).on_white
    puts"*************************************".center(80).black.on_white
    puts "Welcome to JPL's Space Missions!".center(80).black.on_white
    puts"*************************************".center(80).black.on_white
    puts"".center(80).black.on_white
    puts"".center(80).black.on_white
    puts"This Ruby Gem is based on data from NASA's Jet Propulsion Laboratory.".center(80).black.on_white
    puts"JPL, based in Los Angeles is one of NASA's three space flight centers.".center(80).black.on_white
    puts"Welcome to your universe!".center(80).black.on_white
    puts"".center(80).on_white
    puts"".center(80).on_white
    puts"".center(80).blue.on_white
    puts"".center(80).blue.on_white
  end

  def get_data
    SpaceMissions::Scraper.new.get_mission_links
    puts "\n... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    sleep(2)
    puts "Give us just a few more seconds to search the universe ..."
    puts ""
    sleep(2)
    puts "It's a big universe ..."
    puts ""
    puts "Did you know ... that JPL's roots go back to 1936?"
    puts "That's when a group of researchers at Caltech's Guggenheim Aeronautical Laboratory performed a series of rocket experiments in a dry canyon wash known as Arroyo Seco. They moved out to the valley after an accidental explosion on campus..."
    puts ""
    sleep (2)
    puts "Did you know .... that JPL's has two current missions that launched in 1977? They are the twin Voyager probes ... check them out under 'current' missions ..."
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
    puts "You can also type 'exit' to quit."
    puts ""
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if ["past", "current", "future", "proposed"].include?(input)
        list = SpaceMissions::Mission.send("find_by_status", input)
        display_missions(list)
        refine_search?
      elsif input == 'all'
        list = SpaceMissions::Mission.all
        display_missions(list)
        refine_search?
      elsif input == 'exit'
        goodbye
      else
        error
      end
    end
  end

  def display_missions(list)
    @list = list
    @list.each.with_index(1) do |mission, index|
      if mission.acronym == nil
        puts "#{index}. #{mission.name}".colorize(:blue)
      else
        puts "#{index}. #{mission.acronym} - #{mission.name}".colorize(:blue)
      end
    end
  end

  def get_mission(input)
    if input.to_i > 0 && input.to_i < @list.size
      mission = @list[input.to_i - 1]
      if mission
        show_info(mission)
      else
        error
      end
    end
  end

  def show_info(mission)
    puts ""
    puts "Fast facts about #{mission.name}:".colorize(:blue)
    puts ""
    puts "Acronym: #{mission.acronym}".colorize(:blue) if mission.acronym
    puts "Status: #{mission.status}".colorize(:blue) if mission.status
    puts "Description: #{mission.description}".colorize(:blue) #if mission.description
    puts "Type: #{mission.type}".colorize(:blue) if mission.type
    puts "Launch Date: #{mission.launch_date}".colorize(:blue) if mission.launch_date
    puts "Launch Location: #{mission.launch_location}".colorize(:blue) if mission.launch_location
    puts "Landing Date: #{mission.landing_date}".colorize(:blue) if mission.landing_date
    puts "End Date: #{mission.end_date}".colorize(:blue) if mission.end_date
    puts "Mission End Date: #{mission.mission_end_date}".colorize(:blue) if mission.mission_end_date
    puts "Target/s: #{mission.targets}".colorize(:blue) if mission.targets
    puts "Destination/s: #{mission.destinations}".colorize(:blue) if mission.destinations
    puts "Current Location: #{mission.current_location}".colorize(:blue) if mission.current_location
    puts "Altitude: #{mission.altitude}".colorize(:blue) if mission.altitude
    puts "Mission web site: #{mission.url}".colorize(:blue)
    puts ""
    visit_website?(mission)
  end

  def visit_website?(mission)
    puts "Would you like to visit this mission\'s website? Type 'Yes' or 'No'"
    puts ""
    input = nil
    while input != "exit"
    input = gets.strip.downcase
      if input.downcase == 'yes'
        mission.open_in_browser
        search_again?
      elsif input == 'no'
        search_again?
      elsif input == 'exit'
        goodbye
      else
        error
      end
    end
    goodbye if input == 'exit'
  end

#*************************   user interface ********************

  def listen(input=nil)
    while input != "exit"
      input = gets.strip.downcase
      get_mission(input)

      case input.downcase
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
        error
      end#case
    end#while
  end

  def error
    puts "Whoa, are you typing in an alien language?"
    puts "I didn't understand that."
    search_again?
  end

  def search_again?
    puts ""
    puts "If you'd like to start a new seach, type 'new'."
    puts "Or type 'exit' to quit this program'"
    puts ""
    listen
  end

  def refine_search?
    puts ""
    puts "If you'd like to refine your search, use one of these commands:"
    puts ""
    puts "'target' => search missions by target (planet, universe, etc.)"
    puts "'launch' => search missions by launch date"
    puts "'description' => search missions by mission description"
    puts ""
    puts "If not, enter the number of any mission you'd like to learn more about."
    listen
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
      search_again?
    else
      @list = list
      display_missions(list)
      puts ""
      puts "Please enter the number of a mission you'd like to learn more about."
      puts "You can also type exit or 'new' to start a new search."
      puts ""
      listen
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
        error
      else
        launched_before_or_after
        launched_between
      end
    end#while
    new_search?
  end

  def launched_before_or_after
    if @input[1].to_i > 999 && @input[1].to_i < 9999
      if ["before", "after"].include?(@input[0].downcase)
        parameter = @input[0]
        year = @input[1]
        @list = SpaceMissions::Mission.launched(parameter, year)
        search_results
      else
        error
      end
    end
    new_search?
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
          @list = SpaceMissions::Mission.launched("between", start_year, end_year)
          search_results
        end
        goodbye if @input == exit
      end#2nd while
    end
  end

  #********************************************************

  def goodbye
    puts "Thanks for visiting! Please come back soon!"
    exit
  end



end
