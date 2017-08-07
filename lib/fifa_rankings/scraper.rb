# going to use the fixtures for scraping and testing until the code is almost ready to go in order to avoid over-scraping and being blocked from Wikipedia

class FifaRankings::Scraper

  def self.scrape_rankings_page(ranking_url)
    # need to change the html variable assignment when it's time to live test
    html = open(ranking_url)
    doc = Nokogiri::HTML(html)
    teams = []
    i = 2 #should this be more abstract somehow?
    while i < 22 #change this to just be based on the table size
      # teams = doc.css('table.wikitable tr')[i].css('td').collect do |attribute|
      #   team = {
      #     name: attribute[2].css('a'),text,
      #     points: attribute[3].text,
      #     team_url: attribute[2].css('a').attribute('href').value
      #   }
      # end
      team = {
        name: doc.css('table.wikitable tr')[i].css('td')[2].css('a').text,
        points: doc.css('table.wikitable tr')[i].css('td')[3].text.to_i,
        team_url: doc.css('table.wikitable tr')[i].css('td')[2].css('a').attribute('href').value,
      }
      # can this be handled in a better way?
      if i < 11
        team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,1).strip.to_i
      else
        team[:rank] = doc.css('table.wikitable tr')[i].css('td').text.slice(0,2).strip.to_i
      end

      # this converts the Increase/Decrease/Steady into up arrow, down arrow and em dash
      if doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value == "Increase"
        team[:movement] = "  \u2206"
      elsif doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value == "Decrease"
        team[:movement] = "  \u2207"
      elsif doc.css('table.wikitable tr')[i].css('td')[1].css('img').attribute('alt').value == "Steady"
        team[:movement] = "  \u2014"
      end

      teams << team
      i += 1
      end #end of while loop
    teams
  end #end of scrape_rankings_page


  def self.scrape_team_page(team_url)

      doc = Nokogiri::HTML(open(team_url))
      x, i = 0, 0
      attributes = {}
      keys = ["Confederation", "Head coach", "Captain", "Most caps", "Top scorer"]

      while doc.css('table.infobox tbody tr')[i].css('th').text != "FIFA code"
        # stops looking when it gets to the FIFA code row (this does mean my program could break if Wikipedia decides to change the table order)
        # is it worth refactoring to have the keys not be an array?
          # the attributes hash would already be set up with the desired properties and then get filled in when there's a match
        if doc.css('table.infobox tbody tr')[i].css('th').text == keys[x]
          if keys[x] == "Confederation"
            attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tbody tr')[i].css('td').text.gsub(/\[\d+\]/,"").gsub("\n"," ")
          else
            attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tbody tr')[i].css('td').text.gsub(/\[\d+\]/,"").gsub("\n",", ")
          end
          x += 1
        else
          i += 1
        end #end of if statement
      end #end of while loop
      attributes
  end #end of scrape_team_page

end #end of Scraper class
