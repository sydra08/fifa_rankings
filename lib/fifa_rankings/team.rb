class FifaRankings::Team
  attr_accessor :name, :head_coach, :confederation, :rank, :points, :captain, :movement, :most_caps, :top_scorer, :team_url

  @@all = []

  def initialize(team_hash)
    team_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    @@all << self
  end

  def self.create_from_array(array)
    # create Team instances from an array of hashes
    array.each {|team| self.new(team)}
  end

  def add_attributes(attributes_hash)
    # add attributes to Team instances from a hash for the detail view
    attributes_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    self
  end

  def self.sort_by_rank
    self.all.sort_by {|team| team.rank.to_i}
  end

  def self.all
    @@all
  end

  def self.find_by_rank(rank)
    self.all.detect {|team| team.rank == rank}
  end

  def self.find_by_name(name)
    self.all.detect {|team| team.name.downcase == name.downcase}
  end

end
