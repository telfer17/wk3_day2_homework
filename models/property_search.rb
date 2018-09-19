require('pg')

class PropertySearch

  attr_accessor :address, :value, :bedrooms, :year_built, :status, :size, :build
  attr_reader :id

  def initialize(address)
    @id = address["id"].to_i if address["id"]
    @address = address["address"]
    @value = address["value"].to_i
    @bedrooms = address["bedrooms"].to_i
    @year_built = address["year_built"].to_i
    @status = address["status"]
    @size = address["size"].to_i
    @build = address["build"]
  end

  def save()
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "INSERT INTO property_search
    (address, value, bedrooms, year_built, status, size, build)
    VALUES
    ($1, $2, $3, $4, $5, $6, $7)
    RETURNING *"

    values = [@address, @value, @bedrooms, @year_built, @status, @size, @build]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end


  def delete()
    db = PG.connect({ dbname: "property_finder", host: "localhost" })

    sql = "DELETE FROM property_search WHERE id = $1"
    # values should always be an array, even if it's only 1 item
    values = [@id]

    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end


  def update()
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "UPDATE property_search SET (address, value, bedrooms, year_built, status, size, build)
    =
    ($1, $2, $3, $4, $5, $6, $7)
    WHERE id = $8"

    values = [@address, @value, @bedrooms, @year_built, @status, @size, @build, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end


  def PropertySearch.all()
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "SELECT * FROM property_search ORDER BY id"

    db.prepare("all", sql)
    full_list = db.exec_prepared("all")
    db.close()
    return full_list.map {|order_hash| PropertySearch.new(order_hash)}
  end


  def PropertySearch.delete_all()
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "DELETE FROM property_search"

    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def PropertySearch.find_id(id)
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "SELECT * FROM property_search WHERE id = $1"
    values = [id]

    db.prepare("find_property", sql)
    results_array = db.exec_prepared("find_property", values)
    db.close()

    property_hash = results_array[0]
    found_property = PropertySearch.new(property_hash)
    return found_property
  end


  def PropertySearch.find_by_address(address)
    db = PG.connect({dbname: "property_finder", host: "localhost"})

    sql = "SELECT * FROM property_search WHERE address = $1"
    values = [address]

    db.prepare("find_address", sql)
    results_array = db.exec_prepared("find_address", values)
    db.close()

    property_hash = results_array[0]
    found_property = PropertySearch.new(property_hash)
    return found_property
  end

end
