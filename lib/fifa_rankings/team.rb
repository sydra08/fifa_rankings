class FifaRankings::Team
  attr_accessor :name, :head_coach, :confederation, :rank, :points, :captain, :movement, :most_caps, :top_scorer, :highest_rank, :lowest_rank
  # attr_reader :gender
  #
  # @@mens_teams = []
  # @@womens_teams = []

  # basic outline of Team class

  # be able to create Team instances from an array of hashes
  # be able to add attributes to Team instances from a hash
  # when the Team instance is initialized, it will set the gender based on the url...?
    # maybe instead the Scraper class passes the gender as an argument alongside the array of team hashes
      # need to figure out how to determine if mens or womens => can that be based on the url?
        # if the url contains "FIFA_Women" then @gender = "womens" else @gender = "mens"

  def initialize(team_hash,gender)
    # instantiate a Team instance and if it's "mens" add it to the mens array, else add it to the womens array
      # this gives me the ability to conditionalize what to show and when
    # team_hash.each do |k,v|
      # self.send(("#{k}="),v)
    # end
    # @gender = gender
    # if @gender == "mens"
    #   @@mens_teams << self
    # elsif @gender == "womens"
    #   @@womens_teams << self
    # end
  end

  def self.create_from_array(array, gender)
    # create Team instances from an array of hashes
    # array.each {|team| self.new(team, gender)}
      # is it possible to pass the gender argument here and then pass it to #initialize?
  end

  def self.add_attributes(attributes_hash)
    # add attributes to Team instances from a hash for the detail view
    # attributes_hash.each do |k,v|
    #   self.send(("#{k}="),v)
    # end
    # self
  end


  def self.mens_rankings
    # display the mens teams sorted by ranking
  #   @@mens_teams.sort_by {|team| team.rank}
  end

  def self.womens_rankings
    # display the womens teams sorted by ranking
  #   @@womens_teams.sort_by {|team| team.rank}
  end

  def self.mens_teams
    team1 = self.new
    team1.name = "Germany"
    team1.points = 1609
    team1.movement = "Up"
    team2 = self.new
    team2.name = "Brazil"
    team2.points = 1603
    team2.movement = "Down"
    team3 = self.new
    team3.name = "Argentina"
    team3.points = 1413
    team3.movement = "Down"

    [team1, team2, team3]
  end

end
