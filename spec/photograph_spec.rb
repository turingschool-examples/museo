require './lib/photograph'
require './lib/artist'

RSpec.describe Photograph do
  before (:each) do
    @attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photograph = Photograph.new(@attributes)
  end

  it "exists" do
    expect(@photograph).to be_instance_of Photograph
  end

  it "has an id" do
    expect(@photograph.id).to be_instance_of String
    expect(@photograph.id).to eq('1')
  end

  it "has an name" do
    expect(@photograph.name).to be_instance_of String
    expect(@photograph.name).to eq("Rue Mouffetard, Paris (Boy with Bottles)")
  end

  it "has an artist_id" do
    expect(@photograph.artist_id).to be_instance_of String
    expect(@photograph.artist_id).to eq("4")
  end

  it "has an year" do
    expect(@photograph.year).to be_instance_of String
    expect(@photograph.year).to eq("1954")
  end
end
