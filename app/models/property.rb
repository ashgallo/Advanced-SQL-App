class Property < ApplicationRecord
  belongs_to :agent
  has_one :address

  #will need to filter by the join table, city from address
  def self.by_city(city)
    select('properties.id, price, beds, baths, sq_ft')
    .joins('INNER JOIN addresses a 
              ON a.property_id = properties.id')
    .where('LOWER(a.city) = ? 
              AND properties.sold <> TRUE', city.downcase)
  end

  #Property.available
  #Property.select ('....')  
  def self.available
    #use the full table name for properties since its ambiguous.  ad.city, state, street are declaritive, will have to specify what ad means (refers to address.city)
    #using the properties, address(join table), & agent(join table) tables
    #sql query is in captial letters, .joins will join the tables & specify what the ad & a is tied to
    select('properties.id, price, beds, baths, sq_ft,
            ad.city, ad.street, a.first_name,
            a.last_name, a.email, a.id AS agent_id')
    .joins('INNER JOIN agents a 
              ON a.id = properties.agent_id
            INNER JOIN addresses ad 
              ON ad.property_id = properties.id')
    .where('properties.sold <> TRUE')
    .order('a.id')
  end
end
