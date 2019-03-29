                  SELECT *
                   FROM customer c INNER JOIN weapon w
                   ON c.id = w.id AND c.name = '" + str_array.first + "'
                   AND c.sex = true ;