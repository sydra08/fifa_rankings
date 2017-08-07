class FifaRankings::CLI
  @@format = '%-6s %-14s %-10s' #not sure if this is the best way to represent this

  def welcome
    puts ""
    puts "Welcome!"
    puts "Retrieving data..."
  end

  def call
    welcome
    load_data
    list
    details
    goodbye
  end

  def load_data
    get_teams
    add_attributes
  end

  def get_teams
    teams = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Womens-Wiki.html')
    FifaRankings::Team.create_from_array(teams)
  end

  def add_attributes
    FifaRankings::Team.all.each do |team|
      attributes = FifaRankings::Scraper.scrape_team_page('./fixtures/' + team.name + '-Womens-Wiki.html')
      team.add_attributes(attributes)
    end
  end

  def list
    puts ""
    puts "FIFA Women's World Rankings".upcase
    puts "---------------------------"
    puts ""
    puts @@format % ["RANK", "TEAM", "CHANGE"]
    FifaRankings::Team.sort_by_rank.each.with_index(1) do |team, i|
      puts @@format % [i, team.name, team.movement]
    end
  end

  def print_team(rank)
    # maybe get rid of the dashes because the unevenness will annoy me?
    team = FifaRankings::Team.find_by_rank(rank)
    # seems like ||= would be really good here but not sure how to incorporate it just yet

    puts ""
    puts "  #{team.name.upcase}"
    puts "-" * 78 #78 is the longest line + 2 on either side for spacing
    puts "  Rank:" + " #{team.rank}"
    puts "  Points:" + " #{team.points}"
    puts "  Confederation:" + " #{team.confederation}"
    puts "  Head coach:" + " #{team.head_coach}"
    puts "  Team captain:" + " #{team.captain}"
    puts "  Top scorer:" + " #{team.top_scorer}"
    puts "  Most caps:" + " #{team.most_caps}"
    puts "-" * 78
  end

  def details
    input = nil
    while input != "exit"
      puts ""
      puts ""
      puts "Enter the rank of the team that you would like more info on, type 'list' to see whole list, or type 'exit' to leave"
      input = gets.chomp.downcase

      if input.to_i.between?(1,FifaRankings::Team.all.size)
        #make sure the input is within the correct range
        print_team(input.to_i)
      elsif input == "list"
        list
      elsif input != "exit"
        puts ""
        puts "Incorrect input, please try again."
      end
    end #end of while loop
  end #end of details

  def goodbye
    puts ""
    puts "Goodbye! Come back to see the updated rankings soon."
  end

end #end of CLI class
