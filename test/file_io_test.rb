require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_io'

class FileIOTest < Minitest::Test
  def test_it_can_load_artists
    artists = FileIO.load_artists
    assert_equal 6, artists.length
    artist = {
      id: "4",
      name: "Walker Evans",
      born: "1903",
      died: "1975",
      country: "United States"
    }
    assert_equal artist, artists[3]
  end

  def test_it_can_load_photographs
    photographs = FileIO.load_photographs
    assert_equal 4, photographs.length
    assert_instance_of Hash, photographs.first
    photograph = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    assert_equal photograph, photographs[2]
  end
end
