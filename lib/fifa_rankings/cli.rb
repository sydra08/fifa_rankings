#CLI controller

class FifaRankings::CLI
  attr_accessor :selection
  @@format = '%-6s %-14s %-8s %-10s' #not sure if this is the best way to represent this  %-8s %-10s

  def welcome
    puts "Welcome!"
  end

  def call
    welcome
    puts "If you would like to see the FIFA Men's World Rankings, type M. If you would like to see the FIFA Women's World Rankings, type W."
    # have a loading message?
    input = gets.chomp
    if input.downcase == "m"
      mens_list
    elsif input.downcase == "w"
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

  def self.get_mens_teams #maybe the logic of men/women should be in the scraper? | should I prime the program and do this at the beginning vs when the user asks for it?
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Mens-Wiki.html')
    teams = FifaRankings::Team.create_from_array(teams)
    teams
  end

  # def self.add_mens_attributes
  #   FifaRankings::Team.all_mens.each do |team|
  #     attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/' + team.name + '-Mens-Wiki.html')
  #     team.add_attributes(attributes)
  #   end
  #   FifaRankings::Team.all_mens
  # end

  def self.get_womens_teams #maybe the logic of men/women should be in the scraper? | should I prime the program and do this at the beginning vs when the user asks for it?
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Womens-Wiki.html')
    FifaRankings::Team.create_from_array(teams)
  end

  def self.add_womens_attributes
    # this fails bc it cannot scrape all of the data properly
    FifaRankings::Team.all_womens.each do |team|
      attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/United States-Womens-Wiki.html')
      # './fixtures/' + team.name + '-Womens-Wiki.html'
      team.add_attributes(attributes)
    end
    FifaRankings::Team.all_womens
  end

  #list can be one method and have 1 arguments?
  # def list(gender)
  #   if gender == "mens"
  #     puts "FIFA Men's World Rankings"
  #   elsif gender == "womens"
  #     puts "FIFA Women's World Rankings"
  #   end
  #   puts "-------------------------"
  #   puts ""
  #   puts @@format % ["RANK", "TEAM", "POINTS", "CHANGE"]
  #   FifaRankings::Team.mens_rankings.each.with_index(1) do |team, i| => need the method to be more flexible...maybe pass an argument to #rankings(gender)?
  #     puts @@format % [i, team.name, team.points, team.movement]
  #     # "#{i}.  #{team.name} - #{team.points} - #{team.movement}"
  #   end
  # end

  def mens_list
    self.selection = "mens"
    self.class.get_mens_teams
    self.class.add_mens_attributes

    puts ""
    puts "FIFA Men's World Rankings"
    puts "-------------------------"
    puts ""
    puts @@format % ["RANK", "TEAM", "POINTS", "CHANGE"]
    # ["Rank", "Team", "Points", "Change"]
    # "Rank   Team - Points - Change"
    FifaRankings::Team.mens_rankings.each.with_index(1) do |team, i|
      puts @@format % [i, team.name, team.points, team.movement]
      # "#{i}.  #{team.name} - #{team.points} - #{team.movement}"
    end
  end

  def womens_list
    self.selection = "womens"
    self.class.get_womens_teams
    self.class.add_womens_attributes

    puts ""
    puts "FIFA Women's World Rankings"
    puts "---------------------------"
    puts ""
    puts @@format % ["RANK", "TEAM", "POINTS", "CHANGE"]
    FifaRankings::Team.womens_rankings.each.with_index(1) do |team, i|
      puts @@format % [i, team.name, team.points, team.movement]
      # "#{i}.  #{team.name} - #{team.points} - #{team.movement}"
    end
  end

  def print_mens_team(rank)
    # need to determine mens v womens here
    # maybe 2 different methods?
    team = FifaRankings::Team.mens_rankings[rank] #maybe need Team#find_by_rank(rank)
    puts ""
    puts "  #{team.name}"
    puts "-----------------"
    puts "  Rank:" + " #{team.rank}"
    puts "  Points:" + " #{team.points}"
    puts "  Confederation:" + " #{team.confederation}"
    puts "  Head coach:" + " #{team.head_coach}"
    puts "  Team captain:" + " #{team.captain}"
    puts "  Top scorer:" + " #{team.top_scorer}"
    puts "  Most caps:" + " #{team.most_caps}"
    puts "-----------------"
  end


  def print_womens_team(rank)
    # maybe get rid of the dashes because the unevenness will annoy me?
    team = FifaRankings::Team.womens_rankings[rank] #maybe need Team#find_by_rank(rank)
    puts ""
    puts "  #{team.name}"
    puts "--------------------------------"
    puts "  Rank:" + " #{team.rank}"
    puts "  Points:" + " #{team.points}"
    puts "  Confederation:" + " #{team.confederation}"
    puts "  Head coach:" + " #{team.head_coach}"
    puts "  Team captain:" + " #{team.captain}"
    puts "  Top scorer:" + " #{team.top_scorer}"
    puts "  Most caps:" + " #{team.most_caps}"
    # puts "  ---"
    # puts "  highest rank:" + " #{team.highest_rank}"
    # puts "  lowest rank" + " #{team.lowest_rank}"
    puts "--------------------------------"
  end

  def details
    input = nil
    while input != "exit"
      puts ""
      puts ""
      puts "Enter the rank of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      # maybe add the ability to choose from the mens or womens again?
      input = gets.chomp.downcase
      # can these 2 things be combined?
      if self.selection == "mens"
        if input.to_i.between?(0,FifaRankings::Team.all_mens.size)
          #make sure the input is within the correct range
          puts ""
          print_mens_team(input.to_i-1)
        elsif input == "list"
          mens_list
        else #why does this show up when exiting?
          # also if you type something incorrectly then you need to type exit multiple times before you can exit
          puts ""
          puts "Incorrect input, please try again."
        end
      elsif self.selection == "womens"
        if input.to_i.between?(0,FifaRankings::Team.all_womens.size)
          #make sure the input is within the correct range
          print_womens_team(input.to_i-1)
        elsif input == "list"
          womens_list
        else
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
