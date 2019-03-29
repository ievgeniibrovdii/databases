require 'pg'

def insert
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'


    puts "Choose the table for insert: "
    table_name = gets.chomp
    puts "Inserting row: "
    str = gets.chomp
    str_array = str.split(',')

    con.transaction do |con|

    if table_name == "weapon"
      con.exec "INSERT INTO \"weapon\" VALUES(" + str_array[0] + ",'" + str_array[1] + "'," + str_array[2] + ",'" + str_array[3] + "')"
      puts "Row was successfully added to the " + table_name + " table!"

    elsif table_name == "customer"
      con.exec "INSERT INTO \"customer\" VALUES(" + str_array[0] + ",'" + str_array[1] + "'," + str_array[2] + ")"
      puts "Row was successfully added to the " + table_name + " table!"

    elsif table_name == "manufacturer"
      con.exec "INSERT INTO \"manufacturer\" VALUES(" + str_array[0] + ",'" + str_array[1] + "','" + str_array[2] + "')"
      puts "Row was successfully added to the " + table_name + " table!"

    else
      puts " Table don't exists! "
    end

      #con.exec "INSERT INTO \"weapon\" VALUES(9,'Pistol',2777, 'Simple_gun')"

    end

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end