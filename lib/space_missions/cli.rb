#CLI Controller
class SpaceMissions::CLI

  def call
    puts "hello from cli.rb"
    list_missions
    menu
    goodbye
  end

  def list_missions
    puts "NASA JPL's Space Missions:"
    @missions = SpaceMissions::Mission.all
    @missions.each_with_index(1) do |mission, index|
      puts "#{index}. #{mission.name} - #{mission.full_name}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      puts "Enter the number of the mission you'd like to learn more about. You can also type 'list' to see the missions again, or type 'exit' "

      if input.to_i > 0
        puts @missions[input.to_i-1]
      elsif input ==  "list"
        list_missions
      else
        puts "Whoops! That's number of a mission. Please try again."
      end
    end
  end

  def goodbye
    puts "Thanks for visiting!"
  end

end
