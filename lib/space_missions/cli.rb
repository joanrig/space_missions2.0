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

    sleep(1)
    puts "... Hang on, we're loading data from 100++ missions for you!"

    SpaceMissions::Scraper.get_attributes
    puts "just finished #get_attributes"

    puts "Did you know Mars has the biggest volcano that we know of?  ... just a few more seonds ..."

    i = 0
    SpaceMissions::Mission.all[0..5].each_with_index do |mission, index|
      puts "#{index+1}. #{mission.acronym} - #{mission.name}"
      i+= 1
    end
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      puts "Enter the number of the mission you'd like to learn more about. You can also type 'list' to see the missions again, or type 'exit' "

      if input.to_i > 0
        mission = SpaceMissions::Mission.all[0..5][input.to_i - 1]
        # attributes = ["type", "status", "launch_date", "launch_location", "mission_end_date", "target", "current_location", "altitude"]
        # attributes.each do |attr|
        #   puts "#{attr.gsub("_", " ").capitalize}: #{mission.attr)}"
        end

      elsif input ==  "list"
        SpaceMissions::Mission.all[0..5].each_with_index.tap
      else
        puts "Whoops! That's not a number of a mission. Please try again."
      end
    end
  end

  def goodbye
    puts "Thanks for visiting!"
  end

end
