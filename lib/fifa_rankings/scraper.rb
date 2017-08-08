class FifaRankings::Scraper

  def self.scrape_rankings_page(ranking_url)
    doc = Nokogiri::HTML(open(ranking_url))
    teams = []
    i = 2 #this is where the data starts in the table

    while i < 22 #this is where the data starts in the table
      team = {
        name: doc.css('table.wikitable tr')[i].css('td')[2].css('a').text,
        points: doc.css('table.wikitable tr')[i].css('td')[3].text.to_i,
        url: doc.css('table.wikitable tr')[i].css('td')[2].css('a').attribute('href').value,
      }
      if i < 11 #when it gets to the double digits rank the data changes a bit
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
      end

    teams
  end

  def self.scrape_team_page(team_url)
    doc = Nokogiri::HTML(open(team_url))
    x, i = 0, 0
    attributes = {}
    keys = ["Confederation", "Head coach", "Captain", "Most caps", "Top scorer"]

    while doc.css('table.infobox tr')[i].css('th').text != "FIFA code"
      if doc.css('table.infobox tr')[i].css('th').text == keys[x]
        if keys[x] == "Confederation"
          attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tr')[i].css('td').text.gsub("\n"," ")
        else
          attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tr')[i].css('td').text.gsub(/\[\d+\]/,"").gsub("\n",", ")
        end
        x += 1
      else
        i += 1
      end
    end
    attributes
  end

end
