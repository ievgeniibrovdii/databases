require 'pg'

def update
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    puts "Choose the table for updating: "
    table_name = gets.chomp
    puts "Update row: "
    str = gets.chomp
    puts "Where (id=.., name=...) ? "
    where_condition = gets.chomp

    con.transaction do |con|

      if table_name == "weapon"
        con.exec "UPDATE \"weapon\" SET " + str + " WHERE " + where_condition
        puts "Row was successfully updated in the " + table_name + " table!"
      elsif table_name == "customer"
        con.exec "UPDATE \"customer\" SET " + str + " WHERE " + where_condition
        puts "Row was successfully updated in the " + table_name + " table!"

      elsif table_name == "manufacturer"
        con.exec "UPDATE \"manufacturer\" SET " + str + " WHERE " + where_condition
        puts "Row was successfully updated in the " + table_name + " table!"

      else
        puts " Table don't exists! "
      end

      #con.exec "UPDATE \"weapon\" SET price=23700 WHERE id=2"

    end


  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end