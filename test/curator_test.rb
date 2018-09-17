require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'

class CuratorTest < Minitest::Test
  def setup
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    @photo_4 = {
      id: "4",
      name: "Monolith, The Face of Half Dome",
      artist_id: "3",
      year: "1927"
    }

    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
  end

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
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    assert_equal 2, curator.photographs.length
    assert_instance_of Photograph, curator.photographs.first
    assert_equal "Moonrise, Hernandez", curator.photographs.last.name
  end

  def test_it_can_add_artists
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    assert_equal 2, curator.artists.length
    assert_instance_of Artist, curator.artists.first
    assert_equal "Ansel Adams", curator.artists.last.name
  end

  def test_it_can_find_an_artist
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    curator.add_artist(@artist_3)
    diane = curator.find_artist_by_id("3")
    assert_equal "Diane Arbus", diane.name
    assert_equal "3", diane.id
  end

  def test_it_can_find_a_photograph
    curator = Curator.new
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    curator.add_photograph(@photo_3)
    curator.add_photograph(@photo_4)
    moonrise = curator.find_photograph_by_id("2")
    assert_equal "Moonrise, Hernandez", moonrise.name
    assert_equal "2", moonrise.id
  end


  def test_it_can_find_an_artists_photographs
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    curator.add_artist(@artist_3)
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    curator.add_photograph(@photo_3)
    curator.add_photograph(@photo_4)
    artist = curator.find_artist_by_id("3")
    photographs = curator.find_photographs_by_artist(artist)
    assert_equal 2, photographs.length
    assert_equal "3", photographs[0].id
    assert_equal "4", photographs[1].id
  end

  def test_it_can_find_artists_with_more_than_one_photograph
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    curator.add_artist(@artist_3)
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    curator.add_photograph(@photo_3)
    curator.add_photograph(@photo_4)
    expected = curator.find_artist_by_id("3")
    assert_equal [expected], curator.artists_with_multiple_photographs
  end

  def test_it_can_find_photos_taken_by_artists_by_an_artist_from_a_certain_country
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    curator.add_artist(@artist_3)
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    curator.add_photograph(@photo_3)
    curator.add_photograph(@photo_4)
    photo_2 = curator.find_photograph_by_id("2")
    photo_3 = curator.find_photograph_by_id("3")
    photo_4 = curator.find_photograph_by_id("4")
    expected = [photo_2, photo_3, photo_4]
    assert_equal expected, curator.photographs_taken_by_artist_from("United States")
    assert_equal [], curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_can_load_photographs
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    assert_equal 4, curator.photographs.length
  end

  def test_it_can_load_artists
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    assert_equal 6, curator.artists.length
  end

  def test_it_can_get_photos_taken_between
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    photo_1 = curator.find_photograph_by_id("1")
    photo_4 = curator.find_photograph_by_id("4")
    assert_equal [photo_1, photo_4], curator.photographs_taken_between(1950..1965)
  end

  def test_it_can_return_a_summary_of_a_photographers_photos_by_what_age_they_were_taken_at
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    curator.load_photographs('./data/photographs.csv')
    diane_arbus = curator.find_artist_by_id("3")
    actual = curator.artists_photographs_by_age(diane_arbus)
    expected = {
      44 => "Identical Twins, Roselle, New Jersey",
      39 => "Child with Toy Hand Grenade in Central Park"
    }
    assert_equal expected, actual
  end
end
