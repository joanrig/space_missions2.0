class SpaceMissions::CLI

  def call
    get_data
    list_missions
    menu
    goodbye
  end

  @@target = nil

  def get_data
    SpaceMissions::Scraper.get_jpl_mission_links
    puts "... Hang on, we're getting data from #{SpaceMissions::Mission.all.size} missions for you!"
    puts "Give us a few seconds to search the universe ..."

    SpaceMissions::Scraper.get_attributes
  end

  def list_missions
    i = 0
    SpaceMissions::Mission.all.each_with_index do |mission, index|
      if mission.acronym == nil
        puts "#{index+1}. #{mission.name}"
      else
        puts "#{index+1}. #{mission.acronym} - #{mission.name}"
        i+= 1
        #binding.pry
      end
    end
    puts "Type the number of any mission you'd like to learn more about."
  end

  def menu(input=nil)
    while input != "exit"
      commands
      input = gets.strip.downcase
      if input.to_i > 0
        # broken!!!!
        mission = SpaceMissions::Mission.all[input.to_i - 1]
        SpaceMissions::Mission.info
      elsif input ==  "list"
        list_missions
      elsif input == "commands"
        commands
      elsif input == "target"
        SpaceMissions::Mission.target
      elsif input == "type"
        SpaceMissions::Mission.type
      elsif input == "launch"
        SpaceMissions::Mission.launch
      elsif input == "end"
        SpaceMissions::Mission.end
      else
        puts "Whoops! That's not a valid command. Please try again."
        commands
      end
    end
  end

  def commands
    puts "Here are some commands you can try:"
    puts ""
    puts "'list' => see the missions again"
    puts "'target' => search the missions by target (planet, universe, etc.)"
    puts "'type' => search missions by type (orbiter, lander, rover, etc)"
    puts "'launch date' => search missions by launch year"
    puts "'end' => search missions by end of mission year"
    puts "'exit' => to exit program"
    puts ""
    puts "What would you like to do?"
  end

  def select(input=nil)
    while input != "exit"
      input = gets.strip.downcase

    end
  end

  def goodbye
    puts "Thanks for visiting!"
  end

end
