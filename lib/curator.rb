require 'pry'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find {|artist| artist.id == id}
  end

  def photographs_by_artist
    artist_hash = {}
     @artists.map do |artist|
       artist_hash[artist] = @photographs.select {|photo| photo.artist_id == artist.id}
     end
    artist_hash
  end

  def artists_with_multiple_photographs
      photographs_by_artist.map do |artist, photo|
        artist.name if photo.count > 1
      end.compact
  end

  def photographs_taken_by_artist_from(country)
    photographs_by_artist.map do |artist, photos|
      photos if artist.country == country
    end.compact.flatten
  end

end
