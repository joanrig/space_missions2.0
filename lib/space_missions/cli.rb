#CLI Controller
class SpaceMissions::CLI

  def call
    puts "hello from cli.rb"
    list_missions
    menu
    goodbye
  end

  def list_missions
    puts "JPL's current Space Missions:"
    puts <<-DOC.gsub /^\s*/, '' #(heredoc)
      1. ASTER - Advanced Spaceborne Thermal Emission and Reflection Radiometer
      2. ASO - Airborne Snow Observatory
      3. AVIRIS-NG - Airborne Visible-Infrared Imaging Spectrometer - Next Generation
    DOC
    @missions = SpaceMissions::Mission.all
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      puts "Enter the number of the mission you'd like to learn more about. You can also type 'list' to see the missions again, or type 'exit' "
      case input
      when "1'
        puts""More info on mission 1"
      when "2"
        puts "More info on mission 2"
      when "3"
        puts "More info on mission 3"
      when "list"
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
