#CLI controller
# currently using fake data here, will want this to be neater and more abstract

class FifaRankings::CLI
  attr_accessor :selection

  def call
    # put better instructions here
    puts "Welcome! If you would like to see the FIFA Men's World Rankings, type M. If you would like to see the FIFA Women's World Rankings, type W."

    input = gets.chomp
    if input.downcase == "m"
      self.selection = "mens"
      mens_list
    elsif input.downcase == "w"
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

  # maybe add some extra spacing before printing the results to make it look nicer in the terminal
  def mens_list
    puts "FIFA Men's World Rankings"
    puts "Rank   Team - Points - Change"
    @mens = FifaRankings::Team.mens_teams
    @mens.each.with_index(1) do |team, i|
      puts "#{i}.   #{team.name} - #{team.points} - #{team.movement}"
    end
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
    while input != "exit"
      puts "Enter the rank of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      # maybe add the ability to choose from the mens or womens again?
      input = gets.chomp.downcase
      if self.selection == "mens"
        if input.to_i > 0 && input.to_i < 4 #make sure the input is within the correct range
          puts "#{FifaRankings::Team.mens_teams[input.to_i-1]}"
        elsif input == "list"
          mens_list
        else #why does this show up when exiting?
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
