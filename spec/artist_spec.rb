require './lib/photograph'
require './lib/artist'

RSpec.describe Artist do
  before (:each) do
    @attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist = Artist.new(@attributes)
  end

  it "exists" do
    expect(@artist).to be_instance_of Artist
  end

  it "has an id" do
    expect(@artist.id).to be_instance_of String
    expect(@artist.id).to eq('2')
  end

  it "has an name" do
    expect(@artist.name).to be_instance_of String
    expect(@artist.name).to eq("Ansel Adams")
  end

  it "has a birth year" do
    expect(@artist.born).to be_instance_of String
    expect(@artist.born).to eq("1902")
  end

  it "has a death year" do
    expect(@artist.died).to be_instance_of String
    expect(@artist.died).to eq("1984")
  end

  it "has a country" do
    expect(@artist.country).to be_instance_of String
    expect(@artist.country).to eq("United States")
  end

  it "has an age of death" do
    expect(@artist.age_at_death).to be_instance_of Integer
    expect(@artist.age_at_death).to eq(82)
  end
end
