class Artist
  attr_reader :id, :name,
              :born, :died,
              :country

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @born = attributes[:born].to_i
    @died = attributes[:died].to_i
    @country = attributes[:country]
  end

  def at_age_of_death
    @died - @born
  end
end
