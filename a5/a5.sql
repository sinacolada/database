use lotrfinal_1;

-- q1

SELECT 
    character_name, COUNT(*) as encounters
FROM
    lotr_character AS c
        JOIN
    lotr_first_encounter AS e ON (c.character_name = e.character1_name
        OR c.character_name = e.character2_name)
GROUP BY character_name;

-- q2

SELECT 
    character_name,
    COUNT(DISTINCT (region_name)) + 1 AS regions_visited
FROM
    lotr_character AS c
        JOIN
    lotr_first_encounter AS e ON (c.character_name = e.character1_name
        OR c.character_name = e.character2_name)
WHERE
    c.homeland <> e.region_name
GROUP BY character_name;

-- q3

SELECT 
    COUNT(*)
FROM
    lotr_region
WHERE
    major_species = 'hobbit';

-- q4

SELECT 
    MAX(region_encounters.encounters)
FROM
    (SELECT 
        region_name, COUNT(*) AS encounters
    FROM
        lotr_first_encounter
    GROUP BY region_name) region_encounters;

-- q5

SELECT 
    region_name
FROM
    lotr_character AS c
        JOIN
    lotr_first_encounter AS e ON (c.character_name = e.character1_name
        OR c.character_name = e.character2_name)
GROUP BY region_name
HAVING COUNT(DISTINCT character_name) = (SELECT 
        COUNT(*)
    FROM
        lotr_character);
    
-- q6

CREATE TABLE book1_encounters AS SELECT * FROM
    lotr_first_encounter
WHERE
    book_id = 1;

-- q7

SELECT 
    *
FROM
    lotr_book
WHERE
    book_id = (SELECT 
            book_id
        FROM
            lotr_first_encounter
        WHERE
            'Frodo' IN (character1_name , character2_name)
                AND 'Faramir' IN (character1_name , character2_name));

-- q8

SELECT 
    r.region_name, GROUP_CONCAT(c.character_name) AS characters
FROM
    lotr_region r
        LEFT JOIN
    lotr_character c ON r.region_name = c.homeland
GROUP BY region_name;

-- q9

SELECT 
    species_name
FROM
    lotr_species
WHERE
    size = (SELECT 
            MAX(size)
        FROM
            lotr_species);

-- q10

SELECT 
    COUNT(*)
FROM
    lotr_character
WHERE
    species = 'human';

-- q11

CREATE TABLE HumanHobbitFirstEncounters AS SELECT e.* FROM
    lotr_first_encounter e
        JOIN
    lotr_character c1 ON e.character1_name = c1.character_name
        JOIN
    lotr_character c2 ON e.character2_name = c2.character_name
WHERE
    'hobbit' IN (c1.species , c2.species)
        AND 'human' IN (c1.species , c2.species);

-- q12

SELECT 
    character_name
FROM
    lotr_character
WHERE
    homeland = 'gondor';

-- q13

SELECT 
    COUNT(*)
FROM
    lotr_character
WHERE
    species = 'hobbit';

-- q14

SELECT 
    region_name, COUNT(*) AS num_characters
FROM
    lotr_region AS r
        JOIN
    lotr_character AS c ON r.region_name = c.homeland
GROUP BY region_name;