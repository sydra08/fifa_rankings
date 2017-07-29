class FifaRankings::Team
  attr_accessor :name, :nickname, :head_coach, :confederation, :rank, :points, :captain, :movement
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
    # puts "FIFA Men's World Rankings"
    # puts "Rank   Team - Points - Change"
    # puts "1.     Germany - 1609 - Up"
    # puts "2.     Brazil - 1603 - Down"
    # puts "3.     Argentina - 1413 - Down"

    team1 = self.new
    team1.name = "Germany"
    # @team1.head_coach = "Joachim Löw"
    # @team1.captain = "Manuel Neuer"
    # @team1.rank = 1
    team1.points = 1609
    team1.movement = "Up"
    # @team1.confederation = "UEFA (Europe)"
    # @team1.nickname = "Nationalelf (national eleven), DFB-Elf (DFB Eleven), Die Mannschaft (The Team)"
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

  # there's a lot of team info, maybe it should be stored in a hash?
end

# + Description (maybe just the first paragraph?)
# + Nicknames
# + Confederation
# + Head Coach
# + Captain
# + Current Ranking
# + Team Name
# + Current Points Total
# + Movement in Rankings (up/down/none)
