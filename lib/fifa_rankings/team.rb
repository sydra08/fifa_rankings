class FifaRankings::Team

  def self.rankings
    puts "FIFA Men's World Rankings"
    puts "Rank   Team - Points - Change"
    puts "1.     Germany - 1609 - Up"
    puts "2.     Brazil - 1603 - Down"
    puts "3.     Argentina - 1413 - Down"
  end

  # attributes for each team
    # + Current Ranking => should this not be a team-level attribute? the ranking can later be conferred by the order in the array?
    # + Team Name
    # + Current Points Total
    # + Movement in Rankings (up/down/none)
    # + Description (maybe just the first paragraph?)
    # + Association
    # + Nicknames
    # + Confederation
    # + Head Coach
    # + Captain
end
