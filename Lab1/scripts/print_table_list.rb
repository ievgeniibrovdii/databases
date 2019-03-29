require 'pg'
require "rubygems"
require "highline/import"
#require "/Users/user/Desktop/DB/Lab1/scripts/insert"
require "../scripts/insert"
#require "/Users/user/Desktop/DB/Lab1/scripts/update"
require "../scripts/update"
#require "/Users/user/Desktop/DB/Lab1/scripts/find"
require "../scripts/find"
#require "/Users/user/Desktop/DB/Lab1/scripts/delete"
require "../scripts/delete"
#require "/Users/user/Desktop/DB/Lab1/scripts/deleteTableData"
require "../scripts/deleteTableData"
#require "../src/main"


def print_table_list
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    puts puts "List of tables: "

    rs = con.exec "SELECT table_name FROM information_schema.tables
          WHERE table_schema = 'public'"

    rs.each do |row|
      puts row['table_name']
    end

    puts "\n"
    loop do
      choose do |menu|
        menu.prompt = "\nPlease select option: "
        menu.choice(:Insert) { insert }
        menu.choice(:Update) { update }
        menu.choice(:Delete) { delete }
        menu.choice(:Find) {  find_menu }
        menu.choice(:Clear_table) {  truncateTable }
        menu.choice(:Back_to_main_menu, "Back to main menu") { main_menu }
      end
    end


  rescue PG::Error => e

    puts e.message

  ensure

    rs.clear if rs
    con.close if con

  end
end