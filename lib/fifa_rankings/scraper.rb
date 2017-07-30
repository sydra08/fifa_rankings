# scraper class
# going to use the fixtures for scraping and testing until the code is almost ready to go in order to avoid over-scraping and being blocked from Wikipedia

# mens ranking page: './fixtures/Mens-Wiki.html'
# womens ranking page: './fixtures/Womens-Wiki.html'

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

    if ranking_url.match(/Womens/)
      #=> this is for the actual url: ranking_url.match(/FIFA_Women/)
      # scraping logic for womens team
      i = 2
      while i < 12
        team = {
          name: doc.css('table.wikitable tr')[i].css('td')[2].css('a').text,
          movement: doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value,
          points: doc.css('table.wikitable tr')[i].css('td')[3].text,
          team_url: doc.css('table.wikitable tr')[i].css('td')[2].css('a').attribute('href').value,
          gender: "womens"
        }
        # can this be handled in a better way?
        if i < 11
          team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,1).strip
        else
          team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,2).strip
        end
        teams << team
        i += 1
      end
    elsif ranking_url.match(/Mens/)
      #=> this is for the actual mens url: ranking_url.match('/FIFA_World_Rankings/')
      #scraping logic for mens team
      i = 3
      while i < 23
        team = {
          name: doc.css('table.wikitable tr')[i].css('td')[2].css('span a').text,
          rank: doc.css('table.wikitable tr')[i].css('td').text.slice(0,2).strip,
          movement: doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value,
          points: doc.css('table.wikitable tr')[i].css('td')[3].text,
          team_url: doc.css('table.wikitable tr')[i].css('td')[2].css('span a').attribute('href').value,
          gender: "mens"
        }
        teams << team
        i += 1
      end
    end
    teams
  end

  def self.scrape_team_page(team_url)
    # scrape the team wiki page and collect the details in a hashes
    # returns a hash of new attributes for a team
      # this will be passed to the Team class and used to add the detail-view attributes to the Team instances
# `
#       # team = {
#       #   head_coach:,
#       #   captain:,
#       #   confederation:,
#       #   most_caps:,
#       #   top_scorer:,
#       #   highest_rank:,
#       #   lowest_rank:
#       # }
#
      html = File.read(team_url)
      doc = Nokogiri::HTML(html)
      # binding.pry
      # association = doc.css('table.infobox tbody tr')[2].css('th').text #=> on the German W and M pages it works up until Association which is [2]
      # looks like teams without world cup wins have different number of preceding child elements
        # it is i-1 for the non-world cup winners (W)

      attributes = {
        confederation: doc.css('table.infobox tbody tr')[3].css('td a').text,
        # error says that they can't get the object, but in pry it looks ok
        head_coach: doc.css('table.infobox tbody tr')[5].css('td a').text,
        captain: doc.css('table.infobox tbody tr')[6].css('td a').first.text,
        #=> only picks up the first captain. is it worth figuring out how to pick up a second if it exists?
        most_caps: doc.css('table.infobox tbody tr')[7].css('td a').text,
        top_scorer: doc.css('table.infobox tbody tr')[8].css('td a').text
        # highest_rank: doc.css('table.infobox tbody tr')[16].css('td').text.slice(0,2).strip!
      }

      attributes
      # lowest_rank = doc.css('table.infobox tbody tr')[17].css('td').text.slice(0,2).strip! #=> this is returning a nil class error. for some reason the html for this element exists but nokogiri is coming up empty
  end

end

test = FifaRankings::Scraper.scrape_rankings_page('./fixtures/Mens-Wiki.html')
