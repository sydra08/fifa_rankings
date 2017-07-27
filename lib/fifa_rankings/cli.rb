#CLI controller

class FifaRankings::CLI

  def welcome
    puts "Current FIFA World Rankings"
  end

  def call
    self.welcome
    puts "Would you like to see the Men's or Women's team rankings?"
    case gets.downcase.chomp
      when "mens"
        puts "FIFA Men's World Rankings
        Rank   Team - Points - Change
        1.   Germany - 1609 - Up
        2.   Brazil - 1603 - Down
        3.   Argentina - 1413 - Down"
      when "womens"
        puts "FIFA Women's World Rankings
        Rank   Team - Points - Change
        1.   USA - 2118 - Up
        2.   Germany - 2111 - Down
        3.   France - 2076 - No Change"
    end
  end

end
