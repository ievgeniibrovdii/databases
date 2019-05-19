require 'sequel'

def executeFunc
  db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')
  db << "CREATE OR REPLACE FUNCTION save_old_weapon()
         RETURNS trigger AS
         $BODY$

          BEGIN
            IF NEW.name <> OLD.name THEN
            INSERT INTO old_weapon(weapon_id, name, price, changed_on, type)
            VALUES(OLD.id, OLD.name, OLD.price, now(), OLD.type);
          END IF;

          RETURN NEW;
         END;
         $BODY$
         LANGUAGE plpgsql VOLATILE
         COST 100;"

end

def createTrigger
  begin

    db = Sequel.connect('postgres://user:1111@localhost:5432/Lab1')
    executeFunc

    db << "CREATE TRIGGER weapon_name_changes
    BEFORE UPDATE
    ON weapon
    FOR EACH ROW
    EXECUTE PROCEDURE save_old_weapon();"

  end
end