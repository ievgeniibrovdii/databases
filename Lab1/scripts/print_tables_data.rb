require 'pg'

def print_tables_data
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    rs = con.exec "SELECT * FROM \"weapon\" "

    puts "\nDATA IN WEAPON TABLE: "
    puts puts "id | name | price | type "

    rs.each do |row|
      puts "%s %s %s %s" % [ row['id'], row['name'], row['price'], row['type'] ]
    end

    rs = con.exec "SELECT * FROM \"customer\" "

    puts "\nDATA IN CUSTOMER TABLE: "
    puts puts "id | name | sex "

    rs.each do |row|
      puts "%s %s %s" % [ row['id'], row['customer_name'], row['sex'] ]
    end

    rs = con.exec "SELECT * FROM \"manufacturer\" "

    puts "\nDATA IN MANUFACTURER TABLE: "
    puts puts "id | name | country "

    rs.each do |row|
      puts "%s %s %s" % [ row['id'], row['factory_name'], row['country'] ]
    end

    #con.exec "IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
    #       WHERE TABLE_NAME = \"Armor\")"
    #rs.each do |row|
    #  puts "%s %s %s" % [ row['id'], row['name'], row['price'] ]
    #end


  rescue PG::Error => e

    puts e.message

  ensure

    rs.clear if rs
    con.close if con

  end
end