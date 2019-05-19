require 'sequel'
require './scripts/triggerProc'

def update
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts "Choose the table for updating: "
    table_name = gets.chomp
    puts "Update row (name: ...) ?"
    str = gets.chomp
    puts "Where (id: ...) ? "
    id = gets.chomp

      if table_name == "weapon"
        #createTrigger
        db[:weapon].where(id: id).update(name: str)
        puts "Row was successfully updated in the " + table_name + " table!"
      elsif table_name == "customer"
        db[:customer].where(id: id).update(customer_name: str)
        puts "Row was successfully updated in the " + table_name + " table!"
      elsif table_name == "manufacturer"
        db[:manufacturer].where(id: id).update(factory_name: str)
        puts "Row was successfully updated in the " + table_name + " table!"
      else
        puts " Table don't exists! "
      end

    #con.exec "UPDATE \"weapon\" SET " + str + " WHERE " + where_condition
    end
end