# Museo

## Preparation

1. Fork this repository.
1. Clone your new repository to your local machine.
1. Run `bundle` from the command line.
1. Run `rake` from the command line.

## Tasks

Add code to the Photograph and Curator class to support the interaction patterns described below.

Use tests to drive your development.

### Iteration 1: Create Photograph Class

In this repository we have an existing Museum and Artist class, and the beginnings of a Photograph class. We're going to add to the Photograph class so that it can respond to the following interaction pattern:

```ruby
> require './lib/photograph'
# => true

> photograph = Photograph.new({name: "Rue Mouffetard, Paris (Boy with Bottles)", artist_id: 4, museum_id: 2, year: 1954})
# => #<Photograph:0x007f98a9c6ace8 ...>

> photograph.id
# => 1

> photograph.artist_id
# => 4

> photograph.museum_id
# => 2

> photograph.name
# => "Rue Moffetard, Paris (Boy with Bottles)"

> photograph.year
# => 1954
```

### Iteration 2: Create Curator

Currently we have the beginnings of a Curator class. Add to that class so that it can respond to the following interaction pattern:

```ruby
> require './lib/curator'
# => true

> curator = Curator.new
# => #<Curator:0x007f98aa0617e8 ...>

> curator.artists
# => []

> curator.museums
# => []

> curator.photographs
# => []

> curator.add_museum({name: "MoMA"})

> curator.museums
# => [#<Museum:0x007f98a91a86e8 @id=1, @name="MoMA">]

> curator.museums.count
# => 1

> curator.museums.first.id
# => 1

> curator.add_artist({name: "Ansel Adams", born: 1902, died: 1984, country: "United States"})

> curator.artists
# => [#<Artist:0x007f98a9b3bd90
  @born=1902,
  @country="United States",
  @died=1984,
  @id=1,
  @name="Ansel Adams">]

> curator.artists.count
# => 1

> curator.arists.first.id
# => 1

> curator.add_photograph({name: "Moonrise, Hernandez", artist_id: 1, museum_id: 1, year: 1941})

> curator.photographs
# => [#<Photograph:0x007f98a9162058
  @artist_id=1,
  @id=1,
  @museum_id=1,
  @name="Moonrise, Hernandez",
  @year=1941>]

> curator.photographs.count
# => 1

> curator.photographs.first.id
# => 1
```

### Iteration 3: Find by ID

Continue to work on the Curator class so that it can support the following interaction pattern.

```ruby
> require './lib/curator'
> curator = Curator.new
> curator.add_museum({name: "Museo de Arte Moderno"})
> museum = curator.find_museum(1)

> museum.name
# => "Museo de Arte Moderno"

> museum.id
# => 1

> curator.add_artist({name: "Ansel Adams", born: 1902, died: 1984, country: "United States"})
> artist = curator.find_artist(1)

> artist.name
# => "Ansel Adams"

> artist.id
# => 1
```

### Iteration 4: Find by Photograph

Continue to work on the Curator class so that it can support the following interaction pattern.

````ruby
> require './lib/curator'
> curator = Curator.new
> curator.add_museum({name: "Metropolitan Museum of Art"})
> curator.add_artist({name: "Diane Arbus", born: 1923, died: 1971, country: "United States"})
> curator.add_photograph({name: "Identical Twins, Roselle, New Jersey", artist_id: 1, museum_id: 1, year: 1967})
> photograph = curator.photographs.first

> museum = curator.find_museum_by_photograph(photograph)
# => #<Museum:0x007fb973b05ca0 @id=1, @name="Metropolitan Museum of Art">

> museum.id
# => 1

> museum.name
# => "Metropolitan Museum of Art"

> artist = curator.find_artist_by_photograph(photograph)
# => #<Artist:0x007fb973a44a50
  @born=1923,
  @country="United States",
  @died=1971,
  @id=1,
  @name="Diane Arbus">

> artist.id
# => 1

> artist.name
# => "Diane Arbus"
```

