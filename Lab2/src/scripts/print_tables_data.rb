require 'sequel'

def print_tables_data
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts "\nDATA IN WEAPON TABLE: "
    puts puts "id | name | price | type "

    weapon = db[:weapon]
    weapon.all
    weapon.each do |row|
      puts "%s %s %s %s" % [ row[:id], row[:name], row[:price], row[:type] ]
    end

    puts "\nDATA IN CUSTOMER TABLE: "
    puts puts "id | name | sex "

    customer = db[:customer]
    customer.all
    customer.each do |row|
      puts "%s %s %s" % [ row[:id], row[:customer_name], row[:sex] ]
    end

    puts "\nDATA IN MANUFACTURER TABLE: "
    puts puts "id | name | country "

    manufacturer = db[:manufacturer]
    manufacturer.all
    manufacturer.each do |row|
      puts "%s %s %s" % [ row[:id], row[:factory_name], row[:country] ]
    end

    puts "\nDATA IN OLD_WEAPON TABLE: "
    puts puts "id | weapon_id | name | price | changed_on | type "

    weapon = db[:old_weapon]
    weapon.all
    weapon.each do |row|
      puts "%s %s %s %s %s %s" % [ row[:id], row[:weapon_id], row[:name], row[:price], row[:changed_on], row[:type] ]
    end

    puts "\n"
  end
end