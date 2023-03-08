require './lib/artist'
require './lib/photograph'
require './lib/curator'

RSpec.describe do Curator
  before :each do
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

  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@curator).to be_a(Curator)
      expect(@curator.photographs).to be_a Array
      expect(@curator.photographs).to be_empty
      expect(@curator.artists).to be_a Array
      expect(@curator.artists).to be_empty
    end
  end

  describe '#add_photo(photo)' do
    it 'can add photos to the curator' do
      @curator.add_photograph(@photo_1)
      @curator.add_photograph(@photo_2)
      expect(@curator.photographs).to eq([@photo_1,@photo_2])
    end
  end

  describe '#add_artists(artist)' do
    it 'can add artists to a curator' do
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      expect(@curator.artists).to eq([@artist_1,@artist_2])
    end
  end

  describe '#find_artist_by_id(id)' do
    it 'returns an artist that has the same id' do
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
  
      @curator.find_artist_by_id("1")
  
      expect(@curator.find_artist_by_id("1")).to eq(@artist_1)
    end
  end

  describe 'Iteration III' do
    before :each do
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      @curator.add_artist(@artist_3)

      @curator.add_photograph(@photo_1)
      @curator.add_photograph(@photo_2)
      @curator.add_photograph(@photo_3)
      @curator.add_photograph(@photo_4)
    end

    describe "#photographs_by_artist" do
      it 'should return a all the photographs per artist as a hash with arrays' do
        expected = {
          @artist_1 => [@photo_1],
          @artist_2 => [@photo_2],
          @artist_3 => [@photo_3, @photo_4]
        }
        expect(@curator.photographs_by_artist).to eq(expected)
      end
    end

    describe '#artists_with_multiple_photographs' do
      it "returns artists with more than one photograph" do
        expect(@curator.artists_with_multiple_photographs).to eq(["Diane Arbus"])
      end
    end

    describe '#photographs_taken_by_artist_from(country)' do
      it "photographs taken by artists" do
        expect(@curator.photographs_taken_by_artist_from("United States").length).to eq 3
        expect(@curator.photographs_taken_by_artist_from("United States")).to eq [@photo_2, @photo_3, @photo_4]
        expect(@curator.photographs_taken_by_artist_from("Argentina")).to be_empty      end
      end
    end
end
