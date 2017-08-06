# basic outline of Team class

# be able to create Team instances from an array of hashes
# be able to add attributes to Team instances from a hash
# when the Team instance is initialized, it will set the gender based on the url...?
  # maybe instead the Scraper class passes the gender as an argument alongside the array of team hashes
    # need to figure out how to determine if mens or womens => can that be based on the url?
      # if the url contains "FIFA_Women" then @gender = "womens" else @gender = "mens"


class FifaRankings::Team
  attr_accessor :name, :head_coach, :confederation, :rank, :points, :captain, :movement, :most_caps, :top_scorer, :team_url

  @@all = []

  def initialize(team_hash)
    # instantiate a Team instance and if it's "mens" add it to the mens array, else add it to the womens array
      # this gives me the ability to conditionalize what to show and when
    team_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    @@all << self

  end

  def self.create_from_array(array)
    # create Team instances from an array of hashes
    array.each {|team| self.new(team)}
      # is it possible to pass the gender argument here and then pass it to #initialize?
  end

  def add_attributes(attributes_hash)
    # add attributes to Team instances from a hash for the detail view
    attributes_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    self
  end

  def self.sort_by_rankings
    # display the womens teams sorted by ranking
    self.all.sort_by {|team| team.rank.to_i}
  end

  def self.all
    @@all
  end

  def self.find_by_rank(rank)
    self.all.detect {|team| team.rank.to_i == rank}
  end


end
