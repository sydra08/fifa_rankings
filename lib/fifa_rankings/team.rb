class FifaRankings::Team
  attr_accessor :name, :nickname, :head_coach, :confederation, :rank, :points, :captain, :movement
  def self.rankings
    puts "FIFA Men's World Rankings"
    puts "Rank   Team - Points - Change"
    puts "1.     Germany - 1609 - Up"
    puts "2.     Brazil - 1603 - Down"
    puts "3.     Argentina - 1413 - Down"
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
