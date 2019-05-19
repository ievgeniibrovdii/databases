require 'sequel'

def insert
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts "Choose the table for insert: "
    table_name = gets.chomp
    puts "Inserting row: "
    str = gets.chomp
    str_array = str.split(',')

    if table_name == "weapon"
      db[:weapon].insert(id: str_array[0], name: str_array[1], price: str_array[2], type: str_array[3])
      puts "Row was successfully added to the " + table_name + " table!"

    elsif table_name == "customer"
      db[:customer].insert(id: str_array[0], customer_name: str_array[1], sex: str_array[2])
      puts "Row was successfully added to the " + table_name + " table!"

    elsif table_name == "manufacturer"
      db[:manufacturer].insert(id: str_array[0], factory_name: str_array[1], country: str_array[2])
      puts "Row was successfully added to the " + table_name + " table!"

    else
      puts " Table don't exists! "
    end

      #con.exec "INSERT INTO \"weapon\" VALUES(9,'Pistol',2777, 'Simple_gun')"

    end
end