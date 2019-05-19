require 'sequel'

def find_menu
  begin
    puts "\n"
    loop do
      choose do |menu|
        menu.prompt = "\nPlease select option: "
        menu.choice(:Find_by_attributes) { find_by_attr }
        menu.choice(:Fulltext_search) { find_fulltext }
        menu.choice(:Back, "Back") { print_table_list }
      end
    end
  end
end

def createTSvector
  begin
    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')
    db.from(:weapon)

    db << "CREATE OR REPLACE FUNCTION make_tsvector(type TEXT)
                RETURNS tsvector AS $$
              BEGIN
                RETURN (setweight(to_tsvector('english', type),'A') );
              END
              $$ LANGUAGE 'plpgsql' IMMUTABLE;"

    db << "CREATE INDEX IF NOT EXISTS idx_fts_weapon ON weapon
    USING gin(make_tsvector(type))"
  end
end

def find_by_attr
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    search_flag = false
    puts "Input attributes for searching: "
    str = gets.chomp
    str_array = str.split(",")
    puts

    weapon_rows = db[:weapon].join(:weapon_to_customer, weapon_id: :id).join(:customer, id: :customer_id)
    weapon_rows = weapon_rows.where(sex: str_array[2]){price >= str_array[0] && price <= str_array[1]}

=begin
    rs = con.exec "SELECT * FROM weapon
                    INNER JOIN weapon_to_customer
                    ON weapon_to_customer.weapon_id = weapon.id AND weapon.price >= " + str_array.first +
                    "AND weapon.price <= " + str_array[1] +
                    " INNER JOIN customer
                    ON customer.id = weapon_to_customer.customer_id AND customer.sex = " + str_array.last
=end

    weapon_rows.each do |row|
      puts "%s %s %s %s" % [ row[:name], row[:price], row[:customer_name], row[:sex] ]
      search_flag = true
    end

    puts "\n"

    if search_flag == false
      puts "Nothing was found!\n"
    end

  end
end


def find_fulltext
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')
    weapon = db[:weapon]

    search_flag = false
    puts "Input text for searching: "
    str = gets.chomp
    #str_array = str.split(" ")
    puts
    search_str = "%" + str + "%"

    #createTSvector()

=begin
    db << "SELECT * FROM weapon WHERE
  make_tsvector(type) @@ to_tsquery('" + str_array.first + " <-> " + str_array.last + "')"

    weapon_rows = weapon.where()

    weapon_rows.each do |row|
      puts "%s %s %s %s" % [ row[:id], row[:name], row[:price], row[:type] ]
      search_flag = true
    end
=end
    #db << "SELECT * FROM weapon WHERE
  #make_tsvector(type) @@ to_tsquery('" + str_array.first + "')"

    weapon_rows = weapon.where(Sequel.like(:type, search_str))

    puts "id | name | price | type \n\n"

    weapon_rows.each do |row|
      puts "%s %s %s %s" % [ row[:id], row[:name], row[:price], row[:type] ]
      search_flag = true
    end

    if search_flag == false
      puts "Nothing was found!"
    end

    puts "\n"

  end
end


