require './lib/photograph'
require './lib/artist'

RSpec.describe Photograph do
  before :each do
    @attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photograph = Photograph.new(@attributes)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@photograph).to be_a(Photograph)
      expect(@photograph.id).to be_a String
      expect(@photograph.name).to be_a String
      expect(@photograph.artist_id).to be_a String
      expect(@photograph.year).to be_a String
    end
  end
end
