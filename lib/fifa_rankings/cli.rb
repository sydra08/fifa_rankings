#CLI controller

class FifaRankings::CLI
  attr_accessor :selection

  def welcome
    puts "Current FIFA World Rankings"
  end

  def call
    welcome
    puts "Would you like to see the Men's or Women's team rankings?"
    case gets.downcase.chomp
      when "mens"
        self.selection = "mens"
        # want to clean the output up a bit and make it look nicer
        mens_list
      when "womens"
        self.selection = "womens"
        womens_list
    end
    # need to handle when there is incorrect input here
    more_info
  end

  def mens_list
    puts "FIFA Men's World Rankings"
    # currently using fake data here, will want this to be neater and more abstract
    puts "Rank   Team - Points - Change"
    puts "1.     Germany - 1609 - Up"
    puts "2.     Brazil - 1603 - Down"
    puts "3.     Argentina - 1413 - Down"
  end

  def womens_list
    puts "FIFA Women's World Rankings"
    puts "Rank   Team - Points - Change"
    puts "1.     USA - 2118 - Up"
    puts "2.     Germany - 2111 - Down"
    puts "3.     France - 2076 - No Change"
  end

  def more_info
    puts "If you would like to see more information about a team, please enter the rank number. Otherwise type 'exit'"
    input = gets.chomp
    if input.downcase == "exit"
      # quit the program
      puts "Goodbye!"
    elsif input.to_i > 0 && self.selection == "mens"# make sure that the input is an integer
      # logic here to determine which rank you selected and return the correct info
      # also need logic to determine if they selected mens or womens first to get the correct info
      case input.to_i
        when 1
          puts "info about Germany"
        when 2
          puts "info about Brazil"
        when 3
          puts "info about Argentina"
      end
    elsif input.to_i > 0 && self.selection == "womens"
      case input.to_i
        when 1
          puts "info about USA"
        when 2
          puts "info about Germany"
        when 3
          puts "info about France"
      end
    # else
    #   puts "Sorry, incorrect input, please try again."
    #   #look back to asking for input (maybe this needs to be a separate method)
    end
  end

end
