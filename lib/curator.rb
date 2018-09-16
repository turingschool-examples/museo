require './lib/photograph'
require './lib/artist'
require './lib/file_io'
require 'pry'

class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph_attributes)
    @photographs << Photograph.new(photograph_attributes)
  end

  def add_artist(artist_attributes)
    @artists << Artist.new(artist_attributes)
  end

  def load_photographs
    photos = FileIO.load_photographs
    photos.each do |photo|
      add_photograph(photo)
    end
  end

  def load_artists
    artists = FileIO.load_artists
    artists.each do |artist|
      add_artist(artist)
    end
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end
end
