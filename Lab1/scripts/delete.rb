require 'pg'

def delete
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'


    puts "Choose the table for delete-row operation: "
    table_name = gets.chomp
    puts "Deleting row by item name: "
    str = gets.chomp

    con.transaction do |con|

      if table_name == "weapon"
        con.exec "DELETE FROM \"weapon\" WHERE name='" + str + "'"
        puts "Row was successfully deleted from " + table_name + " table!"

      elsif table_name == "customer"
        con.exec "DELETE FROM \"customer\" WHERE name='" + str + "'"
        puts "Row was successfully deleted from " + table_name + " table!"

      elsif table_name == "manufacturer"
        con.exec "DELETE FROM \"manufacturer\" WHERE name='" + str + "'"
        puts "Row was successfully deleted from " + table_name + " table!"

      else
        puts " Table don't exists! "
      end

      # DELETE FROM Customers WHERE name='Pistol'

    end

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end