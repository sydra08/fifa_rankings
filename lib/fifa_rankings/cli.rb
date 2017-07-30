#CLI controller

class FifaRankings::CLI
  attr_accessor :selection

  def call
    puts "Welcome! If you would like to see the FIFA Men's World Rankings, type M. If you would like to see the FIFA Women's World Rankings, type W."
    input = gets.chomp
    if input.downcase == "m"
      self.selection = "mens"
      self.class.get_mens_teams
      self.class.add_mens_attributes
      mens_list
    elsif input.downcase == "w"
      self.selection = "womens"
      self.class.get_womens_teams
      self.class.add_womens_attributes
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
    teams = FifaRankings::Team.create_from_array(teams)
    teams
  end

  def self.add_mens_attributes
    FifaRankings::Team.all_mens.each do |team|
      attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/' + team.name + '-Mens-Wiki.html')
      team.add_attributes(attributes)
    end
    FifaRankings::Team.all_mens
  end

  def self.get_womens_teams
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Womens-Wiki.html')
    FifaRankings::Team.create_from_array(teams)
  end

  def self.add_womens_attributes
    FifaRankings::Team.all_womens.each do |team|
      attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/' + team.name + '-Womens-Wiki.html')
      team.add_attributes(attributes)
    end
    FifaRankings::Team.all_womens
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

  def print_mens_team(rank)
    # need to determine mens v womens here
    # maybe 2 different methods?
    team = FifaRankings::Team.mens_rankings[rank]
    puts ""
    puts "#{team.name}"
    puts "----------------------"
    puts "  rank:" + " #{team.rank}"
    puts "  points:" + " #{team.points}"
    puts "  ---"
    puts "  confederation:" + " #{team.confederation}"
    puts "  head coach:" + " #{team.head_coach}"
    puts "  team captain:" + " #{team.captain}"
    puts "  top scorer:" + " #{team.top_scorer}"
    puts "  most caps:" + " #{team.most_caps}"
    puts "  ---"
    puts "  highest rank:" + " #{team.highest_rank}"
    puts "  lowest rank" + " #{team.lowest_rank}"
    puts "----------------------"
  end


  def print_womens_team(rank)
    # need to determine mens v womens here
    # maybe 2 different methods?
    team = FifaRankings::Team.womens_rankings[rank]
    puts ""
    puts "#{team.name}"
    puts "----------------------"
    puts "  rank:" + " #{team.rank}"
    puts "  points:" + " #{team.points}"
    puts "  ---"
    puts "  confederation:" + " #{team.confederation}"
    puts "  head coach:" + " #{team.head_coach}"
    puts "  team captain:" + " #{team.captain}"
    puts "  top scorer:" + " #{team.top_scorer}"
    puts "  most caps:" + " #{team.most_caps}"
    puts "  ---"
    puts "  highest rank:" + " #{team.highest_rank}"
    puts "  lowest rank" + " #{team.lowest_rank}"
    puts "----------------------"
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
          print_mens_team(input.to_i-1)
        elsif input == "list"
          mens_list
        else #why does this show up when exiting?
          puts ""
          puts "Incorrect input, please try again."
        end
      elsif self.selection == "womens"
        if input.to_i > 0 && input.to_i < 21
          #make sure the input is within the correct range
          print_womens_team(input.to_i-1)
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
