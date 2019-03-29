require 'pg'

def delete_table
  begin
    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    con.exec "DROP TABLE IF EXISTS Armor"
    puts "Table Armor was deleted from database"

  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con
  end
end