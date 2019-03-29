require 'pg'

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


def find_by_attr
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    search_flag = false
    puts "Input attributes for searching: "
    str = gets.chomp
    str_array = str.split(",")
    puts


    rs = con.exec "SELECT * FROM weapon
                    INNER JOIN weapon_to_customer
                    ON weapon_to_customer.weapon_id = weapon.id AND weapon.price >= " + str_array.first +
                    "AND weapon.price <= " + str_array[1] +
                    " INNER JOIN customer
                    ON customer.id = weapon_to_customer.customer_id AND customer.sex = " + str_array.last

    rs.each do |row|
      puts "%s %s %s %s" % [ row['name'], row['price'], row['customer_name'], row['sex'] ]
      search_flag = true
    end

    puts "\n"
=begin

    if str_array.last == "t" || str_array.last == "f"
      rs = con.exec "SELECT *
                     FROM \"customer\" c INNER JOIN \"weapon\" w
                     ON c.id = w.id AND c.customer_name = '" + str_array.first + "'
                     AND c.sex = '" + str_array.last + "'"

      #puts "\nData was found in WEAPON table: "
      puts "name | price | customer_name | sex "

      rs.each do |row|
          puts "%s %s %s %s" % [ row['name'], row['price'], row['customer_name'], row['sex'] ]
          search_flag = true
      end


####################################################

    else str_array.last != "t" || str_array.last != "f"
      rs = con.exec "SELECT *
                     FROM \"weapon\" w INNER JOIN \"manufacturer\" m
                     ON m.id = w.id AND w.name = '" + str_array.first + "'
                     AND w.price = '" + str_array.last + "'"

      #puts "\nData was found in WEAPON table: "
      puts "name | price | manufacturer_name | country "

      rs.each do |row|
        puts "%s %s %s %s" % [ row['name'], row['price'], row['factory_name'], row['country'] ]
        search_flag = true
      end
    end

    puts

=begin
    rs = con.exec "SELECT * FROM \"weapon\" "

    rs.each do |row|
      if row['name'] == str_array.first and row['price'] == str_array.last
        puts "\nData was found in WEAPON table: "
        puts "id | name | price | type "
        puts puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
        search_flag = true
      end
    end

    rs = con.exec "SELECT * FROM \"customer\" "

    rs.each do |row|
      if row['name'] == str_array.first and row['sex'] == str_array.last
        puts "\nData was found in CUSTOMER table: "
        puts "id | name | sex "
        puts puts"%s %s %s" % [ row['id'], row['name'], row['sex'] ]
        search_flag = true
      end
    end

    rs = con.exec "SELECT * FROM \"manufacturer\" "

    rs.each do |row|
      if row['name'] == str_array.first and row['country'] == str_array.last
        puts "\nData was found in MANUFACTURER table: "
        puts "id | name | country "
        puts puts "%s %s %s" % [ row['id'], row['name'], row['country'] ]
        search_flag = true
      end
    end
=end

    if search_flag == false
      puts "Nothing was found!"
    end

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end


def find_fulltext
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    search_flag = false
    puts "Input text for searching: "
    str = gets.chomp
    str_array = str.split(" ")

    puts

    rs = con.exec "SELECT * FROM \"weapon\" "

    con.exec "CREATE OR REPLACE FUNCTION make_tsvector(type TEXT)
              RETURNS tsvector AS $$
            BEGIN
              RETURN (setweight(to_tsvector('english', type),'A') );
            END
            $$ LANGUAGE 'plpgsql' IMMUTABLE;"

    con.exec "CREATE INDEX IF NOT EXISTS idx_fts_weapon ON weapon
  USING gin(make_tsvector(type))"

    puts "id | name | price | type \n\n"
#=begin
    rs = con.exec "SELECT id, name, price, type FROM weapon WHERE
  make_tsvector(type) @@ to_tsquery('" + str_array.first + " <-> " + str_array.last + "')"

    rs.each do |row|
      puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
    end

    rs = con.exec "SELECT id, name, price, type FROM weapon WHERE
  make_tsvector(type) @@ to_tsquery('" + str_array.first + "')"

    rs.each do |row|
      puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
      search_flag = true
    end
=begin
    ########## ts_headline ###########

     rs = con.exec "SELECT id, name, price, ts_headline('english', type, q) FROM weapon,
          to_tsquery('" + str_array.first + "') AS q
        WHERE make_tsvector(type) @@ q"

    rs.each do |row|
      puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
      search_flag = true
    end
=begin
    rs.each do |row|
      if row['type'].include? str
        puts "\nData was found in WEAPON table: "
        puts "id | name | price | type "
        puts puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
        search_flag = true
      end
    end
=end

    if search_flag == false
      #puts "Nothing was found!"
    end

    puts "\n"

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end


