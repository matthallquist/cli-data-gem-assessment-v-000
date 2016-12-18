class Brewery
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @beers = []
    save
  end

  def beers
    @beers
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.find_or_create(brewer)
    exists = self.all.detect{|b| b.name == brewer}
    if exists == nil
      brew = Brewery.new(brewer)
    else
      exists
    end
  end

end
