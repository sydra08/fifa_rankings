#CLI controller

class FifaRankings::CLI
  attr_accessor :selection

  def call
    puts "Welcome! If you would like to see the FIFA Men's World Rankings, type M. If you would like to see the FIFA Women's World Rankings, type W."
    input = gets.chomp
    if input.downcase == "m"
      self.selection = "mens"
      self.class.get_mens_teams
      mens_list
    elsif input.downcase == "w"
      self.selection = "womens"
      self.class.get_womens_teams
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

  def self.get_mens_teams
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Mens-Wiki.html')
    FifaRankings::Team.create_from_array(teams)
  end

  def self.get_womens_teams
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Womens-Wiki.html')
    FifaRankings::Team.create_from_array(teams)
  end

  def mens_list
    puts ""
    puts ""
    puts "FIFA Men's World Rankings"
    puts "Rank   Team - Points - Change"
    FifaRankings::Team.mens_rankings.each.with_index(1) do |team, i|
      puts "#{i}.   #{team.name} - #{team.points} - #{team.movement}"
    end
  end

  def womens_list
    puts ""
    puts ""
    puts "FIFA Women's World Rankings"
    puts "Rank   Team - Points - Change"
    FifaRankings::Team.womens_rankings.each.with_index(1) do |team, i|
      puts "#{i}.   #{team.name} - #{team.points} - #{team.movement}"
    end
  end

  def details
    input = nil
    while input != "exit"
      puts ""
      puts ""
      puts "Enter the rank of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      # maybe add the ability to choose from the mens or womens again?
      input = gets.chomp.downcase
      if self.selection == "mens"
        if input.to_i > 0 && input.to_i < 21
          #make sure the input is within the correct range
          puts ""
          puts "#{FifaRankings::Team.mens_rankings[input.to_i-1]}"
        elsif input == "list"
          mens_list
        else #why does this show up when exiting?
          puts ""
          puts "Incorrect input, please try again."
        end
      elsif self.selection == "womens"
        if input.to_i > 0 && input.to_i < 21
          #make sure the input is within the correct range
          puts ""
          puts "#{FifaRankings::Team.womens_rankings[input.to_i-1]}"
        elsif input == "list"
          womens_list
        else #why does this show up when exiting?
          puts ""
          puts "Incorrect input, please try again."
        end
      end
    end
  end

  def goodbye
    puts "Goodbye!"
  end

end
