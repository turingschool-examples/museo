require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/photograph'
require './lib/artist'
require './lib/curator'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  config.profile_examples = 3
end

RSpec.describe "Museo Spec Harness" do
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
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    @artist_2 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    @artist_3 = Artist.new({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })

    @curator = Curator.new
  end

  context "iteration 1" do
    it '1. tests photograph instantiation' do
      expect(Photograph).to respond_to(:new).with(1).argument
      expect(@photo_1).to be_an_instance_of(Photograph)
    end

    it '2. tests photograph attributes and data types' do
      expect(@photo_1).to respond_to(:id).with(0).argument
      expect(@photo_1).to respond_to(:name).with(0).argument
      expect(@photo_1).to respond_to(:artist_id).with(0).argument
      expect(@photo_1).to respond_to(:year).with(0).argument

      expect(@photo_1.id).to be_an_instance_of(String)
      expect(@photo_1.id).to eq('1')

      expect(@photo_1.name).to be_an_instance_of(String)
      expect(@photo_1.name).to eq('Rue Mouffetard, Paris (Boy with Bottles)')

      expect(@photo_1.artist_id).to be_an_instance_of(String)
      expect(@photo_1.artist_id).to eq('1')

      expect(@photo_1.year).to be_an_instance_of(String)
      expect(@photo_1.year).to eq('1954')
    end

    it '3. tests artist instantiation' do
      expect(Artist).to respond_to(:new).with(1).argument
      expect(@artist_1).to be_an_instance_of(Artist)
    end

    it '4. tests artist attributes and data types' do
      expect(@artist_1).to respond_to(:id).with(0).argument
      expect(@artist_1).to respond_to(:name).with(0).argument
      expect(@artist_1).to respond_to(:born).with(0).argument
      expect(@artist_1).to respond_to(:died).with(0).argument
      expect(@artist_1).to respond_to(:country).with(0).argument

      expect(@artist_1.id).to be_an_instance_of(String)
      expect(@artist_1.id).to eq('2')

      expect(@artist_1.name).to be_an_instance_of(String)
      expect(@artist_1.name).to eq('Ansel Adams')

      expect(@artist_1.born).to be_an_instance_of(String)
      expect(@artist_1.born).to eq('1902')

      expect(@artist_1.died).to be_an_instance_of(String)
      expect(@artist_1.died).to eq('1984')

      expect(@artist_1.country).to be_an_instance_of(String)
      expect(@artist_1.country).to eq('United States')
    end
  end

  context "iteration 2" do
    it '1. tests curator instantiation' do
      expect(Curator).to respond_to(:new).with(0).argument
      expect(@curator).to be_an_instance_of(Curator)
    end

    it '2. tests curator attributes and data types' do
      expect(@curator).to respond_to(:photographs).with(0).argument
      expect(@curator).to respond_to(:artists).with(0).argument

      expect(@curator.photographs).to be_an_instance_of(Array)
      expect(@curator.photographs).to eq([])

      expect(@curator.artists).to be_an_instance_of(Array)
      expect(@curator.artists).to eq([])
    end

    it '3. tests curator can add one photograph' do
      expect(@curator).to respond_to(:add_photograph).with(1).argument

      @curator.add_photograph(@photo_1)
      expect(@curator.photographs).to eq([@photo_1])

      @curator.add_photograph(@photo_2)
      expect(@curator.photographs).to eq([@photo_1, @photo_2])
    end

    it '4. tests curator can add one artist' do
      expect(@curator).to respond_to(:add_artist).with(1).argument

      @curator.add_artist(@artist_1)
      expect(@curator.artists).to eq([@artist_1])

      @curator.add_artist(@artist_2)
      expect(@curator.artists).to eq([@artist_1, @artist_2])
    end

    it '5. tests curator can find artist by id' do
      expect(@curator).to respond_to(:find_artist_by_id).with(1).argument

      @curator.add_artist(@artist_2)
      @curator.add_artist(@artist_1)

      exercise = @curator.find_artist_by_id(@artist_1.id)
      expect(exercise).to be_an_instance_of(Artist)
      expect(exercise).to eq(@artist_1)
    end

    it '6. tests curator can find photo by id' do
      expect(@curator).to respond_to(:find_photograph_by_id).with(1).argument

      @curator.add_photograph(@photo_2)
      @curator.add_photograph(@photo_1)

      exercise = @curator.find_photograph_by_id(@photo_1.id)
      expect(exercise).to be_an_instance_of(Photograph)
      expect(exercise).to eq(@photo_1)
    end
  end

  context 'iteration 3' do
    before :each do
      @curator.add_artist(@artist_1)
      @curator.add_artist(@artist_2)
      @curator.add_artist(@artist_3)
      @curator.add_photograph(@photo_1)
      @curator.add_photograph(@photo_2)
      @curator.add_photograph(@photo_3)
      @curator.add_photograph(@photo_4)
    end
    it '1. curator can find photographs by artist' do
      expect(@curator).to respond_to(:find_photographs_by_artist).with(1).argument

      exercise = @curator.find_photographs_by_artist(@artist_3)
      expect(exercise).to be_an_instance_of(Array)
      expect(exercise).to eq([@photo_3, @photo_4])
    end

    it '2. curator can find artists with multiple photographs' do
      expect(@curator).to respond_to(:artists_with_multiple_photographs).with(0).argument

      exercise = @curator.artists_with_multiple_photographs
      expect(exercise).to be_an_instance_of(Array)
      expect(exercise).to eq([@artist_3])
    end

    it '3. curator can find photos taken from a country' do
      expect(@curator).to respond_to(:photographs_taken_by_artist_from).with(1).argument

      exercise = @curator.photographs_taken_by_artist_from('United States')
      expect(exercise).to be_an_instance_of(Array)
      expect(exercise).to eq([@photo_2, @photo_3, @photo_4])

      expect(@curator.photographs_taken_by_artist_from("Argentina")).to eq([])
    end
  end

  context 'iteration 4' do
    it '1. curator can load photos from csv' do
      expect(@curator).to respond_to(:load_photographs).with(1).argument

      @curator.load_photographs('./data/photographs.csv')
      expect(@curator.photographs.length).to eq(4)

      photo = @curator.find_photograph_by_id('1')
      expect(photo.name).to eq(@photo_1.name)
      photo = @curator.find_photograph_by_id('2')
      expect(photo.name).to eq(@photo_2.name)
      photo = @curator.find_photograph_by_id('3')
      expect(photo.name).to eq(@photo_3.name)
      photo = @curator.find_photograph_by_id('4')
      expect(photo.name).to eq('Child with Toy Hand Grenade in Central Park')
    end

    it '2. curator can load artists from csv' do
      expect(@curator).to respond_to(:load_artists).with(1).argument

      @curator.load_artists('./data/artists.csv')
      expect(@curator.artists.length).to eq(6)

      artist = @curator.find_artist_by_id('1')
      expect(artist.name).to eq('Henri Cartier-Bresson')
      artist = @curator.find_artist_by_id('2')
      expect(artist.name).to eq('Ansel Adams')
      artist = @curator.find_artist_by_id('3')
      expect(artist.name).to eq('Diane Arbus')
      artist = @curator.find_artist_by_id('4')
      expect(artist.name).to eq('Walker Evans')
      artist = @curator.find_artist_by_id('5')
      expect(artist.name).to eq('Manuel Alvarez Bravo')
      artist = @curator.find_artist_by_id('6')
      expect(artist.name).to eq('Bill Cunningham')
    end

    it '3. curator can find photos taken between two years' do
      expect(@curator).to respond_to(:photographs_taken_between).with(1).argument

      @curator.load_artists('./data/artists.csv')
      @curator.load_photographs('./data/photographs.csv')

      exercise = @curator.photographs_taken_between(1000..1900)
      expect(exercise).to be_an_instance_of(Array)
      expect(exercise).to eq([])

      exercise = @curator.photographs_taken_between(1950..1965)
      photo_1 = @curator.photographs[0]
      photo_2 = @curator.photographs[3]
      expect(exercise).to eq([photo_1, photo_2])

      exercise = @curator.photographs_taken_between(1900..1999)
      photo_1 = @curator.photographs[0]
      photo_2 = @curator.photographs[1]
      photo_3 = @curator.photographs[2]
      photo_4 = @curator.photographs[3]
      expect(exercise).to eq([photo_1, photo_2, photo_3, photo_4])
    end

    it '4. curator can rank artists by their age' do
      expect(@curator).to respond_to(:artists_photographs_by_age).with(1).argument

      @curator.load_artists('./data/artists.csv')
      @curator.load_photographs('./data/photographs.csv')

      expected = {
        44=>"Identical Twins, Roselle, New Jersey",
        39=>"Child with Toy Hand Grenade in Central Park"
      }
      exercise = @curator.artists_photographs_by_age(@artist_3)

      expect(exercise).to be_an_instance_of(Hash)
      expect(exercise.keys.first).to be_an_instance_of(Integer)
      expect(exercise.values.first).to be_an_instance_of(String)

      expect(exercise).to eq(expected)
    end
  end
end
