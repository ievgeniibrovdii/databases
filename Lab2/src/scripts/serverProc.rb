require 'sequel'

def createServerProc
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')

    db << "CREATE OR REPLACE PROCEDURE changePrice(INT, INT, INT)
    LANGUAGE plpgsql
    AS $$
    BEGIN

      UPDATE weapon
      SET price = price - $3
      WHERE id = $1;

      UPDATE weapon
      SET price = price + $3
      WHERE id = $2;

      COMMIT;
    END;
    $$;"

    db << "CALL changePrice(226092, 382138, 1000);"

    #db.execute("begin changePrice(:id_one, :id_two, :delta_price); end;", {:arguments => [[226092, "integer"], [382138, "integer"], [1000, "integer"]]}) { |cursor| [cursor[3], cursor[4]] }

    puts "\n Stored procedure successfully changed weapon's prices! \n\n"

  end
end