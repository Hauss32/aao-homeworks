DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS countries;


CREATE TABLE countries(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    population INTEGER NOT NULL
);

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country_id INTEGER NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

INSERT INTO
    countries
    (name, population)
VALUES
    ('United States', 250000000),
    ('Divided States', 100000000)
;

INSERT INTO 
    animals
    (name, country_id)
VALUES
    ('Horse', (SELECT id FROM countries WHERE name = 'United States')),
    ('Raccoon', (SELECT id FROM countries WHERE name = 'United States')),
    ('Aligator', (SELECT id FROM countries WHERE name = 'Divided States')),
    ('Rattlesnake', (SELECT id FROM countries WHERE name = 'Divided States'))
;