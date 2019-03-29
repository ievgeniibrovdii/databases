require 'pg'

def add_table
    begin
    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    con.exec "DROP TABLE IF EXISTS Armor"
    con.exec "CREATE TABLE Armor(id INTEGER PRIMARY KEY,
          name VARCHAR(20), price INT)"
    con.exec "INSERT INTO Armor VALUES(1,'Helmet',52642)"
    con.exec "INSERT INTO Armor VALUES(2,'BodyArmor',57127)"
    con.exec "INSERT INTO Armor VALUES(3,'Knapsack',9000)"
    con.exec "INSERT INTO Armor VALUES(4,'Patches',29000)"
    con.exec "INSERT INTO Armor VALUES(5,'Cuirass',350000)"
    con.exec "INSERT INTO Armor VALUES(6,'Equipage',21000)"
    con.exec "INSERT INTO Armor VALUES(7,'Suit',41400)"

    puts "Table Armor was added to database"
  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con
  end
end