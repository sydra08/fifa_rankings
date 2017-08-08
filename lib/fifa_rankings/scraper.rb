class FifaRankings::Scraper

  def self.scrape_rankings_page(ranking_url)
    html = open(ranking_url)
    doc = Nokogiri::HTML(html)
    teams = []
    i = 2 #this is where the data starts
    while i < 22 #this is the where the data stops
      team = {
        name: doc.css('table.wikitable tr')[i].css('td')[2].css('a').text,
        points: doc.css('table.wikitable tr')[i].css('td')[3].text.to_i,
        team_url: doc.css('table.wikitable tr')[i].css('td')[2].css('a').attribute('href').value,
      }
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

      teams << team #sandwich code?
      i += 1
      end
    teams
  end

  def self.scrape_team_page(team_url)

      doc = Nokogiri::HTML(open(team_url))
      x, i = 0, 0
      attributes = {}
      keys = ["Confederation", "Head coach", "Captain", "Most caps", "Top scorer"]

      while doc.css('table.infobox tbody tr')[i].css('th').text != "FIFA code"
        if doc.css('table.infobox tbody tr')[i].css('th').text == keys[x]
          if keys[x] == "Confederation"
            attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tbody tr')[i].css('td').text.gsub(/\[\d+\]/,"").gsub("\n"," ")
          else
            attributes[keys[x].downcase.gsub(" ","_").to_sym] = doc.css('table.infobox tbody tr')[i].css('td').text.gsub(/\[\d+\]/,"").gsub("\n",", ")
          end
          x += 1
        else
          i += 1
        end
      end
      attributes
  end

end
