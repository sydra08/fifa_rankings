class FifaRankings::CLI

  def call
    welcome
    load_data
    list
    details
    goodbye
  end

  def welcome
    puts ""
    puts "Welcome!"
    puts "Retrieving FIFA data..."
  end

  def goodbye
    puts ""
    puts "Goodbye! Come back to see the updated rankings soon."
  end

  def load_data
    get_teams
    add_attributes
  end

  def get_teams
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Womens-Wiki.html')
    # teams = FifaRankings::Scraper.scrape_rankings_page('https://en.wikipedia.org/wiki/FIFA_Women%27s_World_Rankings')
    FifaRankings::Team.create_from_array(teams)
  end

  def add_attributes
    FifaRankings::Team.all.each do |team|
      attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/' + team.name + '-Womens-Wiki.html')
      # attributes = FifaRankings::Scraper.scrape_team_page('https://en.wikipedia.org' + team.url)
      team.add_attributes(attributes)
    end
  end

  def list
    format = '%-6s %-14s %-10s'

    puts ""
    puts "FIFA Women's World Rankings".upcase
    puts "---------------------------"
    puts ""
    puts format % ["RANK", "TEAM", "CHANGE"]
    FifaRankings::Team.sort_by_rank.each.with_index(1) do |team, i|
      puts format % [i, team.name, team.movement]
    end
  end


  def details
    input = nil
    while input != "exit"
      puts ""
      puts ""
      puts "Enter the rank or name of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      input = gets.chomp.downcase

      if input.to_i.between?(1,FifaRankings::Team.all.size) || FifaRankings::Team.find_by_name(input)
        print_team(input)
      elsif input == "list"
        list
      elsif input != "exit"
        puts ""
        puts "Incorrect input, please try again."
      end

    end
  end

  def print_team(input)
    team = FifaRankings::Team.find_by_rank(input.to_i) || FifaRankings::Team.find_by_name(input)

    puts ""
    puts "  #{team.name.upcase}"
    puts "-" * 78 #74 is the longest line + 2 on either side for spacing
    puts "  Rank:" + " #{team.rank}"
    puts "  Points:" + " #{team.points}"
    puts "  Confederation:" + " #{team.confederation}"
    puts "  Head coach:" + " #{team.head_coach}"
    puts "  Team captain(s):" + " #{team.captain}"
    puts "  Top scorer(s):" + " #{team.top_scorer}"
    puts "  Most caps:" + " #{team.most_caps}"
    puts "-" * 78
  end

end
