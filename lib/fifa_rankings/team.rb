class FifaRankings::Team
  attr_accessor :name, :head_coach, :confederation, :rank, :points, :captain, :movement, :most_caps, :top_scorer, :highest_rank, :lowest_rank
  # attr_reader :gender
  #
  # @@mens_teams = []
  # @@womens_teams = []

  # def initialize(gender)
  #   @gender = gender
  #   if @gender == "mens"
  #     @@mens_teams << self
  #   elsif @gender == "womens"
  #     @@womens_teams << self
  #   end
  # end

  # def self.mens_teams
  #   @@mens_teams
  # end

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
