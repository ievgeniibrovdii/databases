require "rubygems"
require "highline/import"
#require "/Users/user/Desktop/DB/Lab1/scripts/create_table"
require "../scripts/create_table"
#require "/Users/user/Desktop/DB/Lab1/scripts/print_table_list"
require "../scripts/print_table_list"
#require "/Users/user/Desktop/DB/Lab1/scripts/print_tables_data"
require "../scripts/print_tables_data"
#require "/Users/user/Desktop/DB/Lab1/scripts/delete_table"
require "../scripts/delete_table"
#require "/Users/user/Desktop/DB/Lab1/scripts/randomFill"
require "../scripts/randomFill"

# pg_ctl -D /usr/local/var/postgres start

def main_menu
  begin
    puts "\n"
    loop do
      choose do |menu|
        menu.prompt = "\nPlease select option: "
        menu.choice(:Show_tables_list) { print_table_list }
        menu.choice(:Show_tables_data) { print_tables_data }
        menu.choice(:Random_filling_tables) { randomFillTables }
        menu.choice(:Add_some_table) {  add_table }
        menu.choice(:Delete_some_table) {  delete_table }
        menu.choice(:Exit, "Exit program.") { exit }
      end
    end
  end
end

main_menu