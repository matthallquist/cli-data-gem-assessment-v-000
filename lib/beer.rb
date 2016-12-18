class Beer
  attr_accessor :rating, :name, :brewery, :type, :abv

  def initialize(rating, name, brewery, type, abv)
    @rating = rating
    @name = name
    @brewery = brewery
    @type = type
    @abv = abv
  end

end
