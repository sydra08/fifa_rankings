#CLI controller

class FifaRankings::CLI
  attr_accessor :selection

  def call
    puts "Would you like to see the Men's or Women's team rankings?"
    # currently using fake data here, will want this to be neater and more abstract
    input = gets.chomp
    if input.downcase == "mens"
      self.selection = "mens"
      mens_list
    elsif input.downcase == "womens"
      self.selection = "womens"
      womens_list
    else
      puts "Please try again"
      call
    end
    details
    goodbye
  end

  # want to clean the output up a bit and make it look nicer - consider this:
  # https://stackoverflow.com/questions/19068075/output-an-array-of-objects-to-terminal-as-a-table-with-attributes-in-fixed-widt

  def mens_list
    # binding.pry
    # puts "FIFA Men's World Rankings"
    # puts "Rank   Team - Points - Change"
    # puts "1.     Germany - 1609 - Up"
    # puts "2.     Brazil - 1603 - Down"
    # puts "3.     Argentina - 1413 - Down"
    FifaRankings::Team.rankings
    @team1 = FifaRankings::Team.new
    @team1.name = "Germany"
    # @team1.head_coach = "Joachim Löw"
    # @team1.captain = "Manuel Neuer"
    # @team1.rank = 1
    # @team1.points = 1609
    # @team1.movement = "up"
    # @team1.confederation = "UEFA (Europe)"
    # @team1.nickname = "Nationalelf (national eleven), DFB-Elf (DFB Eleven), Die Mannschaft (The Team)"
    @team2 = FifaRankings::Team.new
    @team2.name = "Brazil"
    @team3 = FifaRankings::Team.new
    @team3.name = "Argentina"
  end

  def womens_list
    puts "FIFA Women's World Rankings"
    puts "Rank   Team - Points - Change"
    puts "1.     USA - 2118 - Up"
    puts "2.     Germany - 2111 - Down"
    puts "3.     France - 2076 - None"
  end

  def details
    input = nil
    while input != "exit" #need to add another control for incorrect input
      puts "Enter the rank of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      # maybe add the ability to choose from the mens or womens again?
      input = gets.chomp.downcase
      if self.selection == "mens" # make sure that the input is an integer
        # logic here to determine which rank you selected and return the correct info
        case input
        when "1"
          puts @team1
        when "2"
          puts @team2
        when "3"
        puts @team3
        when "list"
          mens_list
        else
          puts "Incorrect input, please try again."
        end
      elsif self.selection == "womens"
        case input
        when "1"
          puts "info about USA"
        when "2"
          puts "info about Germany"
        when "3"
          puts "info about France"
        when "list"
          womens_list
        else
          puts "Incorrect input, please try again."
          #this is showing up when exiting
        end
      end
    end
  end

  def goodbye
    puts "Goodbye!"
  end

end
