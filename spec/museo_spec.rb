require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/photograph'
require './lib/artist'
require './lib/curator'

RSpec.configure do |config|
  config.default_formatter = 'doc'
end

RSpec.describe 'Museo Spec' do
  before :each do
    photo_attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }

    artist_attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @photograph = Photograph.new(photo_attributes)
    @artist = Artist.new(artist_attributes)
    @curator = Curator.new
  end

  describe 'Iteration 1' do
    it '1. Photo Creation' do
      expect(Photograph).to respond_to(:new).with(1).argument
      expect(@photograph).to be_an_instance_of(Photograph)
      expect(@photograph).to respond_to(:id).with(0).argument
      expect(@photograph.id).to eq("1")
      expect(@photograph).to respond_to(:name).with(0).argument
      expect(@photograph.name).to eq("Rue Mouffetard, Paris (Boy with Bottles)")
      expect(@photograph).to respond_to(:artist_id).with(0).argument
      expect(@photograph.artist_id).to eq("4")
      expect(@photograph).to respond_to(:year).with(0).argument
      expect(@photograph.year).to eq("1954")
    end

    it '2. Artist Creation' do
      expect(Artist).to respond_to(:new).with(1).argument
      expect(@artist).to be_an_instance_of(Artist)
      expect(@artist).to respond_to(:id).with(0).argument
      expect(@artist.id).to eq("2")
      expect(@artist).to respond_to(:name).with(0).argument
      expect(@artist.name).to eq("Ansel Adams")
      expect(@artist).to respond_to(:born).with(0).argument
      expect(@artist.born).to eq("1902")
      expect(@artist).to respond_to(:died).with(0).argument
      expect(@artist.died).to eq("1984")
      expect(@artist).to respond_to(:country).with(0).argument
      expect(@artist.country).to eq("United States")
    end

    it '3. Artist #age_at_death' do
      expect(@artist).to respond_to(:age_at_death).with(0).argument
      expect(@artist.age_at_death).to eq(82)
    end
  end

  describe 'Iteration 2' do
    before :each do
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

    it '4. Curator Creation' do
      expect(Curator).to respond_to(:new).with(0).argument
      expect(@curator).to be_an_instance_of(Curator)
      expect(@curator).to respond_to(:photographs).with(0).argument
      expect(@curator.photographs).to eq([])
      expect(@curator).to respond_to(:artists).with(0).argument
      expect(@curator.artists).to eq([])
    end

    it '5. Curator #add_photograph & #add_artist' do
      expect(@curator).to respond_to(:add_photograph).with(1).argument
      @curator.add_photograph(@photo_1)
      @curator.add_photograph(@photo_2)
      expect(@curator.photographs).to eq([@photo_1, @photo_2])
      expect(@curator).to respond_to(:add_artist).with(1).argument
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      expect(@curator.artists).to eq([@artist_1, @artist_2])
    end

    it '6. Curator #find_artist_by_id & #find_photograph_by_id' do
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      expect(@curator).to respond_to(:find_artist_by_id).with(1).argument
      expect(@curator.find_artist_by_id("2")).to eq(@artist_2)
    end
  end

  describe 'Iteration 3' do
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
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      @curator.add_artist(@artist_3)
      @curator.add_photograph(@photo_1)
      @curator.add_photograph(@photo_2)
      @curator.add_photograph(@photo_3)
      @curator.add_photograph(@photo_4)
    end

    it '7. Curator #photographs_by_artist' do
      expect(@curator).to respond_to(:photographs_by_artist).with(0).argument
      expected = {
        @artist_1 => [@photo_1],
        @artist_2 => [@photo_2],
        @artist_3 => [@photo_3, @photo_4],
      }
      expect(@curator.photographs_by_artist).to eq(expected)
    end

    it '8. Curator #artists_with_multiple_photographs' do
      expect(@curator).to respond_to(:artists_with_multiple_photographs).with(0).argument
      expect(@curator.artists_with_multiple_photographs).to eq(["Diane Arbus"])
    end

    it '9. Curator #photographs_taken_by_artist_from' do
      expect(@curator).to respond_to(:photographs_taken_by_artist_from).with(1).argument
      expect(@curator.photographs_taken_by_artist_from("United States")).to eq([@photo_2, @photo_3, @photo_4])
      expect(@curator.photographs_taken_by_artist_from("Argentina")).to eq([])
    end
  end

  describe 'Iteration 4' do
    it '10. Curator #load_photographs && #load_artists' do
      expect(@curator).to respond_to(:load_photographs).with(1).argument
      expect(@curator).to respond_to(:load_artists).with(1).argument
    end

    it '11. Curator #photographs_taken_between' do
      @curator.load_photographs('./data/photographs.csv')
      @curator.load_artists('./data/artists.csv')
      expect(@curator).to respond_to(:photographs_taken_between).with(1).argument
      expect(@curator.photographs_taken_between(1950..1965)[0].id).to eq("1")
      expect(@curator.photographs_taken_between(1950..1965)[1].id).to eq("4")
    end

    it '12. Curator #artists_photographs_by_age' do
      @curator.load_photographs('./data/photographs.csv')
      @curator.load_artists('./data/artists.csv')
      expect(@curator).to respond_to(:artists_photographs_by_age).with(1).argument
      diane_arbus = @curator.find_artist_by_id("3")
      expect(@curator.artists_photographs_by_age(diane_arbus)).to eq({44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"})
    end
  end
end
