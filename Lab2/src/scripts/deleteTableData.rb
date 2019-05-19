require 'sequel'

def truncateTable
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts "Choose the table for deleting all rows: "
    table_name = gets.chomp

    if table_name == "weapon"
      db[:weapon].truncate(cascade: true)
      puts "Table " + table_name + " was cleared!"
    elsif table_name == "customer"
      db[:customer].truncate(cascade: true)
      puts "Table " + table_name + " was cleared!"
    elsif table_name == "manufacturer"
      db[:manufacturer].truncate(cascade: true)
      puts "Table " + table_name + " was cleared!"
    else
      puts " Table don't exists! "
    end

  end
end