# scraper class
# going to use the fixtures for scraping and testing until the code is almost ready to go in order to avoid over-scraping and being blocked from Wikipedia

# mens ranking page: './fixtures/Mens-Wiki.html'
# womens_ranking_page = './fixtures/Womens-Ranking-FIFA.com.html'
# USA_womens_page = './fixtures/USA-Womens-FIFA.com.html'

class FifaRankings::Scraper

  def self.scrape_rankings_page(ranking_url)
    # need to change the if statements and html variable assignment when it's time to live test
    # scrape the rankings page and collect the information for each team
    # how do we handle which wiki page to go to? => should that be passed in via the CLI?
      # could be done when the user is asked to make a choice and the urls could be variables contained within the Scraper class...?
    # returns an array of hashes
      # this will be passed to the Team class and used to create the Team objects
      # team = {
      #   name: ,
      #   rank:,
      #   movement:,
      #   points:,
      #   team_url:
      # }
    html = File.read(ranking_url)
    doc = Nokogiri::HTML(html)
    teams = []
    i = 2 #should this be more abstract somehow?
    while i < 22 #change this to just be based on the table size
      # doc.css('table.wikitable tr')[i].css('td').collect do |attribute|
      #   team = {
      #     name: attribute[2].css('a'),text,
      #     movement: attribute[1].css('img').attribute('alt').value,
      #     points: attribute[3].text,
      #     team_url: attribute[2].css('a').attribute('href').value,
      #     gender: "womens"
      #   }
      # end
      team = {
        name: doc.css('table.wikitable tr')[i].css('td')[2].css('a').text,
        movement: doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value,
        points: doc.css('table.wikitable tr')[i].css('td')[3].text,
        team_url: doc.css('table.wikitable tr')[i].css('td')[2].css('a').attribute('href').value,
      }
      # can this be handled in a better way?
      if i < 11
        team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,1).strip
      else
        team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,2).strip
      end
      teams << team
      i += 1
      end #end of while loop
    teams
  end #end of scrape_rankings_page


  def self.scrape_team_page(team_url)
    # scrape the team wiki page and collect the details in a hashes
    # returns a hash of new attributes for a team
      # this will be passed to the Team class and used to add the detail-view attributes to the Team instances
# `
#       # team = {
#       #   worst_rank:,
#       #   worst_rank_year:,
#       #   best_rank:,
#       #   best_rank_year:
#       #   average_rank_lifetime:,
#       # }
#
      # html = File.read()
      doc = Nokogiri::HTML(open(team_url))
      # binding.pry

      x, i = 0, 0
      attributes = {}
      keys = ["Confederation", "Head coach", "Captain", "Most caps", "Top scorer"]
      while doc.css('table.infobox tbody tr')[i].css('th').text != "FIFA code"
        # stops looking when it gets to the FIFA code row (this does mean my program could break if Wikipedia decides to change the table order)
        # is it worth refactoring to have the keys not be an array?
          # the attributes hash would already be set up with the desired properties and then get filled in when there's a match?
        if doc.css('table.infobox tbody tr')[i].css('th').text == keys[x]
          attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tbody tr')[i].css('td').first.text
          x += 1
        else
          i += 1
        end
        # binding.pry
      end

      attributes
  end #end of scrape_team_page

end #end of Scraper class
