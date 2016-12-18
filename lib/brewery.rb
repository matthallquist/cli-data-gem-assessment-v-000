class Brewery
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @beers = []
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

end
