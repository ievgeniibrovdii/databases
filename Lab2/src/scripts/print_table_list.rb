require 'sequel'
require "rubygems"
require "highline/import"
require "./scripts/insert"
require "./scripts/update"
require "./scripts/find"
require "./scripts/delete"
require "./scripts/deleteTableData"
require "./scripts/serverProc"

def print_table_list
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    puts puts "List of tables: "

    tables = db.tables
    puts tables

    puts "\n"
    loop do
      choose do |menu|
        menu.prompt = "\nPlease select option: "
        menu.choice(:Insert) { insert }
        menu.choice(:Update) { update }
        menu.choice(:Delete) { delete }
        menu.choice(:Find) {  find_menu }
        menu.choice(:Clear_table) {  truncateTable }
        menu.choice(:Stored_proc) {  createServerProc }
        menu.choice(:Back_to_main_menu, "Back to main menu") { main_menu }
      end
    end

    end
end