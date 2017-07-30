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
      # binding.pry
      rank = doc.css('table.wikitable tr')[3].css('td').text.slice(0,2).strip! #=> need to only grab the first number
        # do a slice for the first 2 characters (since the numbers will be double digits eventually)
        # the child number will need to be increased every row
      movement = doc.css('table.wikitable tr')[3].css('td')[1].css('img').attribute('alt').value #=> increase, decrease, steady
      name = doc.css('table.wikitable tr')[3].css('td')[2].css('span a').text
      team_url = doc.css('table.wikitable tr')[3].css('td')[2].css('span a').attribute('href').value
      points = doc.css('table.wikitable tr')[3].css('td')[3].text

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

      html = File.read(team_url)
      doc = Nokogiri::HTML(html)
      # binding.pry
      # association = doc.css('table.infobox tbody tr')[2].css('th').text #=> on the men's page it works up until Association which is [2]
      # description = doc.css('div.mw-parser-output p')
      confederation = doc.css('table.infobox tbody tr')[3].css('td a').text
      head_coach = doc.css('table.infobox tbody tr')[5].css('td a').text
      captain = doc.css('table.infobox tbody tr')[6].css('td a').first.text #=> only picks up the first captain. is it worth figuring out how to pick up a second if it exists?
      most_caps = doc.css('table.infobox tbody tr')[7].css('td a').text
      top_scorer = doc.css('table.infobox tbody tr')[8].css('td a').text
      highest_rank = doc.css('table.infobox tbody tr')[16].css('td').text.slice(0,2).strip!
      # lowest_rank = doc.css('table.infobox tbody tr')[17].css('td').text.slice(0,2).strip! #=> this is returning a nil class error. for some reason the html for this element exists but nokogiri is coming up empty
  end

end

# test = FifaRankings::Scraper.scrape_rankings_page("./fixtures/Mens-Wiki.html")
FifaRankings::Scraper.scrape_team_page("./fixtures/USA-Womens-Wiki.html")
