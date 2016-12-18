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

  def self.scrape_beers
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
    breweries = doc.search("#extendedInfo a:first-child")
    breweries = breweries.map do |b|
      b.text
    end
    types = doc.search("#extendedInfo a:last-child")
    types = types.map do |t|
      t.text
    end
    abvs = doc.search("#extendedInfo:last-of-type")
    abvs = abvs.map do |abv|
      a = abv.text.split(" / ").last
      a = a.split(" ABV")
      a = a[0]
    end
    creation_array = []
    count = 0
    250.times do
      array = []
      array << ratings[count]
      array << names[count]
      array << breweries[count]
      array << types[count]
      array << abvs[count]
      creation_array << array
      count += 1
    end
    creation_array
  end

  def self.create_beers
    array = self.scrape_beers
    array.each do |stats|
      new_brewery = Brewery.find_or_create(stats[2])
      new_beer = Beer.new(stats[0],stats[1],new_brewery,stats[3],stats[4])
      new_beer.brewery.beers << [new_beer]
    end
  end

end
