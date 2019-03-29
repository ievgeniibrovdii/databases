require 'pg'

def truncateTable
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    puts "Choose the table for deleting all rows: "
    table_name = gets.chomp

    if table_name == "weapon"
      con.exec "TRUNCATE TABLE weapon"
      puts "Table " + table_name + " was cleared!"
    elsif table_name == "customer"
      con.exec "TRUNCATE TABLE customer"
      puts "Table " + table_name + " was cleared!"
    elsif table_name == "manufacturer"
      con.exec "TRUNCATE TABLE manufacturer"
      puts "Table " + table_name + " was cleared!"
    else
      puts " Table don't exists! "
    end

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end