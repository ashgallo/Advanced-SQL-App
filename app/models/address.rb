class Address < ApplicationRecord
  belongs_to :property

  #distinct will only show city in one row vs showing multiple times for each home
  def self.cost_by_city
    select("DISTINCT city,
            STRING_AGG(CAST(price AS VARCHAR), ', ' ORDER BY price DESC) AS prices,
            COUNT(*) price")
    .joins('INNER JOIN properties p ON addresses.property_id = p.id')
    .where('p.sold IS TRUE')
    .group('city')
  end
end
