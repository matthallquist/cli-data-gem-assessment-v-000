class Beer
  attr_accessor :rating, :name, :brewery, :type, :abv

  @@all = []

  def initialize(rating, name, brewery, type, abv)
    @rating = rating
    @name = name
    @brewery = brewery
    @type = type
    @abv = abv
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

end
