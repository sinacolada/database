use lotrfinal_1;

-- 1
/* 1. Write a procedure track_character(character_name) that accepts a character name and returns
a result set that contains a list of the other characters that the provided character has encountered.
The result set should contain the character’s name, the region name, the book name, and the name of
the encountered character. (10 points) */

drop procedure if exists track_character;

delimiter //

create procedure track_character(character_name varchar(255))
begin
	SELECT 
		character1_name as `character`,
		character2_name AS character_met,
		region_name,
		title
	FROM
		lotr_first_encounter
			JOIN
		lotr_book USING (book_id)
	WHERE
		character1_name = character_name 
	UNION SELECT 
		character2_name as `character`,
		character1_name AS character_met,
		region_name,
		title
	FROM
		lotr_first_encounter
			JOIN
		lotr_book USING (book_id)
	WHERE
		character2_name = character_name;
end //

delimiter ;

call track_character('Frodo');
call track_character('Sauron');
call track_character('');


-- 2
/* 2. Write a procedure track_region(region) that accepts a region name and returns a result set that
contains the region name, the book name, the number of encounters for that region and the leader of
that region. (10 points) */

drop procedure if exists track_region;

delimiter //

create procedure track_region(region varchar(255))
begin
	SELECT 
		region_name,
		title,
		COUNT(e.region_name) AS num_encounters,
		leader
	FROM
		lotr_region
			JOIN
		lotr_first_encounter AS e USING (region_name)
			JOIN
		lotr_book USING (book_id)
	WHERE
		region_name = region
	GROUP BY title, region_name;
end //

delimiter ;

call track_region('Rivendell');
call track_region('Mordor');
call track_region('');

-- 3
/* 3. Write a function named strongerSpecie(sp1,sp2). It accepts 2 species and returns 1 if sp1 has a 
size larger than sp2, 0 if they have equal sizes, else -1 (10 points) */

drop function if exists strongerSpecie;

delimiter //

create function strongerSpecie(sp1 varchar(255), sp2 varchar(255)) returns int deterministic
begin
	declare sp1_size int; 
    declare sp2_size int;
	SELECT size FROM lotr_species WHERE species_name = sp1 INTO sp1_size;
	SELECT size FROM lotr_species WHERE species_name = sp2 INTO sp2_size;
	if sp1_size > sp2_size then return(1); 
		elseif sp1_size = sp2_size then return(0); 
        else return(-1); 
	end if;
end //

delimiter ;

select strongerSpecie('human', 'orc');
select strongerSpecie('elf', 'human');
select strongerSpecie('human', 'elf');
select strongerSpecie('human', 'fakespecies');
select strongerSpecie('fakespecies', 'human');
select strongerSpecie('fakespecies', 'fakespecies');

-- 4
/* 4. Write a function named region_most_encounters(character) that accepts a character name and 
returns the name of the region where the character has had the most encounters. (10 points) */

drop function if exists region_most_encounters;

delimiter //

create function region_most_encounters(`character` varchar(255)) returns varchar(255) deterministic
begin
	declare region_me varchar(255);
	WITH cte AS (SELECT 
			character_name, region_name, COUNT(*) AS encounters
		FROM
			lotr_character AS c
		JOIN lotr_first_encounter AS e ON (c.character_name = e.character1_name
			OR c.character_name = e.character2_name)
		GROUP BY character_name , region_name)
	SELECT 
		region_name
	FROM
		 cte
	WHERE
		character_name = `character`
	ORDER BY encounters DESC
	LIMIT 1 INTO region_me;
    return region_me;
end //

delimiter ;

select region_most_encounters('Frodo');
select region_most_encounters('Legolas');
select region_most_encounters('Aragorn');
select region_most_encounters('');

-- 5
/* 5. Write a function named home_region_encounter(character) that accepts a character name and 
returns TRUE if the character has had a first encounter in his homeland. FALSE if the character has
not had a first encounter in his homeland. or NULL if the character’s homeland is not known. (10 
points) */

drop function if exists home_region_encounter;

delimiter //

create function home_region_encounter(`character` varchar(255)) returns boolean deterministic
begin
	declare hl varchar(255);
    declare hre boolean;
    SELECT homeland FROM lotr_character WHERE character_name = `character` INTO hl;
	WITH cte AS (SELECT 
			character_name, region_name
		FROM
			lotr_character AS c
		JOIN lotr_first_encounter AS e ON (c.character_name = e.character1_name
			OR c.character_name = e.character2_name)
		GROUP BY character_name , region_name)
	SELECT 
		COUNT(*)
	FROM
		cte
	WHERE
		character_name = `character`
			AND region_name = hl INTO hre;
    if hl is null then return null; 
		else return hre; 
	end if;
end //

delimiter ;

select home_region_encounter('Frodo');
select home_region_encounter('Sauron');
select home_region_encounter('');

-- 6
/* 6. Write a function named encounters_in_num_region(region_name) that accepts a region’s name as an
argument and returns the number of encounters for that region. (10 points) */

drop function if exists encounters_in_num_region;

delimiter //

create function encounters_in_num_region(region_name varchar(255)) returns int deterministic
begin
	declare region_encounters int;
	SELECT 
		COUNT(*)
	FROM
		lotr_first_encounter AS e
	WHERE
		e.region_name = region_name INTO region_encounters;
    return region_encounters;
end //

delimiter ;

select encounters_in_num_region('Rivendell');
select encounters_in_num_region('Mordor');
select encounters_in_num_region('Undying Lands');
select encounters_in_num_region('');

-- 7
/* 7. Write a procedure named fellowship_encounters(book) that accepts a book’s name and returns the
fellowship characters (all fields in the character table) having first encounters in that book. (10
points) */

drop procedure if exists fellowship_encounters;

delimiter //

create procedure fellowship_encounters(book varchar(255))
begin
	SELECT DISTINCT
		c.*
	FROM
		lotr_book
			JOIN
		lotr_first_encounter AS e USING (book_id)
			JOIN
		lotr_character AS c ON (c.character_name = e.character1_name
			OR c.character_name = e.character2_name)
	WHERE
		title = book;
end //

delimiter ;

call fellowship_encounters('the fellowship of the ring');
call fellowship_encounters('the two towers');
call fellowship_encounters('the return of the king');
call fellowship_encounters('');

-- 8
/* 8. Modify the books table to contain a field called encounters_in_book and write a procedure called
initialize_encounters_count(book) that accepts a book id and initializes the field to the number of 
encounters that occur in that book for the current encounters table. The book table modification can
occur outside or inside of the procedure. (10 points) */

ALTER TABLE lotr_book ADD COLUMN encounters_in_book INT;

drop procedure if exists initialize_encounters_book;

delimiter //

create procedure initialize_encounters_book(book int)
begin
	UPDATE lotr_book 
	SET 
		encounters_in_book = (SELECT 
				encounters
			FROM
				(SELECT 
					book_id, COUNT(*) AS encounters
				FROM
					lotr_first_encounter
				GROUP BY book_id) AS book_encounters
			WHERE
				book_id = book)
	WHERE
		book_id = book;
end //

delimiter ;

select * from lotr_book;
call initialize_encounters_book(1);
select * from lotr_book;
call initialize_encounters_book(2);
select * from lotr_book;
call initialize_encounters_book(3);
select * from lotr_book;

-- 9
/* 9. Write a trigger that updates the field encounters_in_book for the book records in the lotr_book 
table. The field should contain the number of first encounters for that book. Call the trigger 
firstencounters_after_insert. Insert the following records into the database. Insert a first encounter
in Rivendell between Legolas and Frodo for book 1 . Ensure that the sencounters_in_book field is 
properly updated for this data. (10 points) */

delimiter //

create trigger firstencounters_after_insert after insert on lotr_first_encounter for each row
begin
	UPDATE lotr_book 
	SET 
		encounters_in_book = encounters_in_book + 1
	WHERE
		book_id = new.book_id;
end //

delimiter ;

select * from lotr_first_encounter;
select * from lotr_book;

INSERT INTO lotr_first_encounter (character1_name, character2_name, book_id, region_name) 
	VALUES ('Legolas', 'Frodo', 1, 'Rivendell');

select * from lotr_first_encounter;
select * from lotr_book;

-- 10
/* 10. Create and execute a prepared statement from the SQL workbench that calls home_region_encounter
with the argument ‘Aragorn’. Use a user session variable to pass the argument to the function. (5 
points) */

prepare stmt_hre from 'select home_region_encounter(?);';

set @hre_arg = 'Aragorn';
execute stmt_hre using @hre_arg;

deallocate prepare stmt_hre;

-- 11
/* 11. Create and execute a prepared statement that calls region_most_encounters() with the argument
‘Aragorn’. Once again use a user session variable to pass the argument to the function. (5 points) */

prepare stmt_rme from 'select region_most_encounters(?);';

set @rme_arg = 'Aragorn';
execute stmt_rme using @rme_arg;

deallocate prepare stmt_rme;
