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

  def scrape_beers
    doc = Nokogiri::HTML(open("https://www.beeradvocate.com/lists/top/"))
    ratings = doc.search("td span:first-child")
    ratings = ratings.map do |r|
      r.text
    end
    ratings.delete_at(0)
    names = doc.search("td a b")
    names = names.map do |n|
      n.text
    end
    brewers = doc.search("#extendedInfo a:first-child")
    brewers = brewers.map do |b|
      b.text
    end
    types = doc.search("#extendedInfo a:last-child")
    types = types.map do |t|
      t.text
    end
  end

end
