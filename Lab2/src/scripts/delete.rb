require 'sequel'

def delete
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts "Choose the table for delete-row operation: "
    table_name = gets.chomp
    puts "Deleting row by item name: "
    str = gets.chomp

      if table_name == "weapon"
        db[:weapon].where(name: str).delete
        puts "Row was successfully deleted from " + table_name + " table!"

      elsif table_name == "customer"
        db[:customer].where(customer_name: str).delete
        puts "Row was successfully deleted from " + table_name + " table!"

      elsif table_name == "manufacturer"
        db[:manufacturer].where(factory_name: str).delete
        puts "Row was successfully deleted from " + table_name + " table!"

      else
        puts " Table don't exists! "
      end

    end
end