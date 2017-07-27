#CLI controller

class FifaRankings::CLI
  
  def welcome
    puts "Current FIFA World Rankings"
  end

  def call
    self.welcome
    puts "Would you like to see the Men's or Women's team rankings?"
  end

end
