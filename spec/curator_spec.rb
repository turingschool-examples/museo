require './lib/photograph'
require './lib/artist'
require './lib/curator'

RSpec.describe Curator do
  before (:each) do
    @curator = Curator.new
    @photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })
    @photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })
    @artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })
    @artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })
  end

  it "exists" do
    expect(@curator).to be_instance_of Curator
  end

  it "has no photographs by default" do
    expect(@curator.photographs).to be_instance_of Array
    expect(@curator.photographs.length).to eq(0)
    expect(@curator.photographs).to eq([])
  end

  it "can add photographs" do
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    expect(@curator.photographs).to be_instance_of Array
    expect(@curator.photographs.length).to eq(2)
    expect(@curator.photographs).to eq([@photo_1, @photo_2])
  end

  it "has no artists by default" do
    expect(@curator.artists).to be_instance_of Array
    expect(@curator.artists.length).to eq(0)
    expect(@curator.artists).to eq([])
  end

  it "can add artists" do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    expect(@curator.artists).to be_instance_of Array
    expect(@curator.artists.length).to eq(2)
    expect(@curator.artists).to eq([@artist_1, @artist_2])
  end

  it "can find artist by id" do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    expect(@curator.find_artist_by_id('1')).to be_instance_of Artist
    expect(@curator.find_artist_by_id('1')).to eq(@artist_1)
  end
end

RSpec.describe "Iteration 3" do
  before (:each) do
    @curator = Curator.new
    @photo_1 = Photograph.new({
     id: "1",
     name: "Rue Mouffetard, Paris (Boy with Bottles)",
     artist_id: "1",
     year: "1954"
    })
    @photo_2 = Photograph.new({
     id: "2",
     name: "Moonrise, Hernandez",
     artist_id: "2",
     year: "1941"
    })
    @photo_3 = Photograph.new({
     id: "3",
     name: "Identical Twins, Roselle, New Jersey",
     artist_id: "3",
     year: "1967"
    })
    @photo_4 = Photograph.new({
     id: "4",
     name: "Monolith, The Face of Half Dome",
     artist_id: "3",
     year: "1927"
    })
    @artist_1 = Artist.new({
     id: "1",
     name: "Henri Cartier-Bresson",
     born: "1908",
     died: "2004",
     country: "France"
    })
    @artist_2 = Artist.new({
     id: "2",
     name: "Ansel Adams",
     born: "1902",
     died: "1984",
     country: "United States"
    })
    @artist_3 = Artist.new({
     id: "3",
     name: "Diane Arbus",
     born: "1923",
     died: "1971",
     country: "United States"
    })
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
  end

  it "finds photographs by artist" do
    expect(@curator.photographs_by_artist).to be_instance_of Hash
    expect(@curator.photographs_by_artist.values.first).to be_instance_of Array
    expect(@curator.photographs_by_artist).to eq({
      @artist_1 => [@photo_1],
      @artist_2 => [@photo_2],
      @artist_3 => [@photo_3, @photo_4]
     })
  end

  it "finds artists with multiple photographs" do
    expect(@curator.artists_with_multiple_photographs).to be_instance_of Array
    expect(@curator.artists_with_multiple_photographs.first).to be_instance_of String
    expect(@curator.artists_with_multiple_photographs.length).to eq(1)
    expect(@curator.artists_with_multiple_photographs).to eq(["Diane Arbus"])
  end

  it "finds photographs taken by artists from a given country" do
    expect(@curator.photographs_taken_by_artist_from("United States")).to be_instance_of Array
    expect(@curator.photographs_taken_by_artist_from("United States").first).to be_instance_of Photograph
    expect(@curator.photographs_taken_by_artist_from("United States").length).to eq(3)
    expect(@curator.photographs_taken_by_artist_from("United States")).to eq([@photo_2, @photo_3, @photo_4])

    expect(@curator.photographs_taken_by_artist_from("Argentina").length).to eq(0)
    expect(@curator.photographs_taken_by_artist_from("Argentina")).to eq([])
  end
end
