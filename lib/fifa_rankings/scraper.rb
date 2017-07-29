# scraper class
# going to use the fixtures for scraping and testing until the code is almost ready to go in order to avoid over-scraping and being blocked from Wikipedia

# mens ranking page: './fixtures/Mens-Wiki.html'
# womens ranking page: './fixtures/Womens-Wiki.html'

class FifaRankings::Scraper

  def self.scrape_rankings_page(ranking_url)
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
      binding.pry
      rank = doc.css('table.wikitable tr')[3].text
      # team = {
      #   name: ,
      #   rank:,
      #   movement:,
      #   points:,
      #   team_url:
      # }

      # get the different rankings page elements for mens teams



  end

  def self.scrape_team_page(team_url)
    # scrape the team wiki page and collect the details in a hashes
    # returns a hash of new attributes for a team
      # this will be passed to the Team class and used to add the detail-view attributes to the Team instances

      # team = {
      #   head_coach:,
      #   captain:,
      #   confederation:,
      #   most_caps:,
      #   top_scorer:,
      #   highest_rank:,
      #   lowest_rank:
      # }

  end

end

test = FifaRankings::Scraper.scrape_rankings_page("./fixtures/Mens-Wiki.html")
