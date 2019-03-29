CREATE OR REPLACE FUNCTION make_tsvector(name TEXT, type TEXT)
   RETURNS tsvector AS $$
BEGIN
  RETURN (setweight(to_tsvector('english', name),'A') ||
    setweight(to_tsvector('english', type), 'B'));
END
$$ LANGUAGE 'plpgsql' IMMUTABLE;


CREATE INDEX IF NOT EXISTS idx_fts_weapon ON weapon
  USING gin(make_tsvector(name, type));

SELECT id, name FROM weapon WHERE
  make_tsvector(name, type) @@ to_tsquery('AK <-> weapon');