require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'

class CuratorTest < Minitest::Test
  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_it_starts_with_no_artists
    curator = Curator.new
    assert_equal [], curator.artists
  end

  def test_it_starts_with_no_photographs
    curator = Curator.new
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = {
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: 4,
      year: 1954
    }
    photo_2 = {
      name: "Moonrise, Hernandez",
      artist_id: 1,
      year: 1941
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal 2, curator.photographs.length
    assert_instance_of Photograph, curator.photographs.first
    assert_equal "Moonrise, Hernandez", curator.photographs.last.name
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = {
      name: "Ansel Adams",
      born: 1902,
      died: 1984,
      country: "United States"
    }
    artist_2 = {
      name: "Diane Arbus",
      born: 1923,
      died: 1971,
      country: "United States"
    }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    assert_equal 2, curator.artists.length
    assert_instance_of Artist, curator.artists.first
    assert_equal "Diane Arbus", curator.artists.last.name
  end

  def test_it_can_load_photographs
    curator = Curator.new
    curator.load_photographs
    assert_equal 4, curator.photographs.length
  end

  def test_it_can_load_artists
    curator = Curator.new
    curator.load_artists
    assert_equal 6, curator.artists.length
  end

  def test_it_can_find_an_artist
    curator = Curator.new
    curator.load_artists
    manuel = curator.find_artist_by_id("5")
    assert_equal "Manuel Alvarez Bravo", manuel.name
    assert_equal "5", manuel.id
  end

  def test_it_can_find_an_artists_photographs
    curator = Curator.new
    curator.load_artists
    curator.load_photographs
    artist = curator.find_artist_by_id("3")
    photographs = curator.find_photographs_by_artist(artist)
    assert_equal 2, photographs.length
    assert_equal "3", photographs[0].id
    assert_equal "4", photographs[1].id
  end

  def test_it_can_find_artists_with_more_than_one_photograph
    curator = Curator.new
    curator.load_artists
    curator.load_photographs
    expected = curator.find_artist_by_id("3")
    assert_equal [expected], curator.artists_with_multiple_photographs
  end
end
