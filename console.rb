require ("pry")
require_relative("./models/property_search")

PropertySearch.delete_all()

property1 = PropertySearch.new({
  'address' => '10 Hope Street',
  'value' => 120000,
  'bedrooms' => 3,
  'year_built' => 1890,
  'status' => 'for sale',
  'size' => 1500,
  'build' => 'townhouse',
  })

  property1.save()

  property2 = PropertySearch.new({
    'address' => '35 Queen Street',
    'value' => 1000,
    'bedrooms' => 2,
    'year_built' => 1910,
    'status' => 'to let',
    'size' => 1200,
    'build' => 'flat',
    })

    property2.save()

    property3 = PropertySearch.new({
      'address' => '87 West Nile Street',
      'value' => 300000,
      'bedrooms' => 4,
      'year_built' => 2000,
      'status' => 'for sale',
      'size' => 3000,
      'build' => 'penthouse',
      })

      property3.save()

      property2.delete()

      property1.value = 100000
      property1.update()

      full_list = PropertySearch.all()

      hope_street = PropertySearch.find_id(property1.id)

      west_nile_street = PropertySearch.find_by_address('87 West Nile Street')


      binding pry
      nil
