require 'pg'

def randomFillTables
  begin

    con = PG.connect :dbname => 'Lab1', :user => 'user',
                     :password => '1111'

    puts
    # random fill for weapon

    name_array = ["AK", "Magnum", "M416", "SKS", "MI26", "G5", "G36", "PompGun", "TacticGun", "C4"]
    sex_array = [true, false]
    type_array = ["Personal weapons (or small arms) – designed to be used by a single person.",
                  "Light weapons – man-portable weapons that may require a small team to operate.",
                  "Heavy weapons – artillery and similar weapons larger than light weapons (see SALW).",
                  "Hunting weapon – used by hunters for sport or getting food.",
                  "Crew served weapons – larger than personal weapons, requiring two or more people to operate correctly.",
                  "Fortification weapons – mounted in a permanent installation, or used primarily within a fortification.",
                  "Mountain weapons – for use by mountain forces or those operating in difficult terrain.",
                  "Vehicle weapons – to be mounted on any type of combat vehicle.",
                  "Railway weapons – designed to be mounted on railway cars, including armored trains.",
                  "Aircraft weapons – carried on and used by some type of aircraft, helicopter, or other aerial vehicle."
    ]

    con.transaction do |con|
     10.times do
        id = Random.rand(99999)
        name = name_array.sample
        price = Random.rand(5000)
        type = type_array.sample
        con.exec "INSERT INTO \"weapon\" VALUES( " + id.to_s + ", " + "'" + name + "' , " + price.to_s + ", " + "'" + type + "' )"
     end
    end

  # random fill for manufacturer

    name_array = ["AMSD", "Beretta", "Arms", "Mecar", "Tampella", "Indep", "Milkor", "AOBC", "Anciens", "Birdsboro"]
    country_array = ["Germany", "Ukraine", "Italy", "Spain", "USA", "Poland", "Portugal", "Iran", "Russia", "France"]

    con.transaction do |con|
      10.times do
        id = Random.rand(99999)
        name = name_array.sample
        country = country_array.sample

        con.exec "INSERT INTO \"manufacturer\" VALUES( " + id.to_s + ", " + "'" + name + "' , " +  "'" + country + "' )"
      end
    end

  # random fill for customer

    name_array = ["Jack", "John", "Said", "Kate", "Camille", "Ievgeniy", "Mayels", "Robert", "Andrew", "Dennis"]

    con.transaction do |con|
      10.times do
        id = Random.rand(99999)
        name = name_array.sample
        sex = sex_array.sample

        con.exec "INSERT INTO \"customer\" VALUES( " + id.to_s + ", " + "'" + name + "' , " +  sex.to_s + " )"
      end
    end


  rescue PG::Error => e

    puts e.message

  ensure

    con.close if con

  end
end