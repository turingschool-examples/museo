require './lib/photograph'
require './lib/artist'

RSpec.describe Artist do
  before :each do
    @attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist = Artist.new(@attributes)
  end

  describe 'initialize' do
    it 'exists and has attributes' do
      expect(@artist).to be_a(Artist)
      expect(@artist.id).to be_a String
      expect(@artist.name).to be_a String
      expect(@artist.born).to be_a Integer
      expect(@artist.died).to be_a Integer
      expect(@artist.country).to be_a String
    end
  end

  describe '#at_age_of_death' do
    it 'calculates the age the artist was when they died' do
      expect(@artist.at_age_of_death).to eq 82
    end
  end

end
