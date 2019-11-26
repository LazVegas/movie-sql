actors (id, name, character_name, movieId, date_of_birth)
links (movie_Id, imdb_Id, tmdb_Id)
movies (id, title, genres)
rating (user_id, movie_id, rating, timestamp)
tags (user_id movie_id ,tagtimestamp)
----------------------------------------------------------

-- Question 1
-- Select all columns and rows from the movies table
SELECT id, title, genres
FROM movies.movies;

-- Question 2
-- Select only the title and id of the first 10 rows
SELECT id, title
FROM movies.movies
LIMIT 10;

-- Question 3
-- Find the movie with the id of 485
SELECT id, title
FROM movies
WHERE id = 485;

-- Question 4
-- Find the id (only that column) of the movie Made in America (1993)
SELECT id
FROM movies
WHERE title LIKE '%made in america%';

-- Question 5
-- Find the first 10 sorted alphabetically
SELECT id, title, genres
FROM movies
ORDER BY title ASC
LIMIT 10;

-- Question 6
-- Find all movies from 2002
SELECT id, title, genres
FROM movies
WHERE title LIKE '%2002%'

-- Question 7
-- Find out what year the Godfather came out
SELECT title
FROM movies
WHERE title LIKE '%Godfather, The%';

-- Question 8
-- Without using joins find all the comedies
SELECT id, title, genres
FROM movies
WHERE genres LIKE '%comedy%'

-- Question 9
-- Find all comedies in the year 2000
SELECT id, title, genres
FROM movies
WHERE genres LIKE '%comedy%' AND title LIKE '%2000%'

-- Question 10
-- Find any movies that are about death and are a comedy
SELECT id, title, genres
FROM movies
WHERE genres LIKE '%comedy%' AND title LIKE '%death%'

-- Question 11
--Find any movies from either 2001 or 2002 with a title containing super
SELECT id, title, genres
FROM movies
WHERE (title LIKE '%2001%' OR title LIKE '%2002%') AND title LIKE '%super%' 

-- Question 12
-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
ALTER TABLE `movies`.`actors`
CHANGE COLUMN `` `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ;

ALTER TABLE `movies`.`actors` 
DROP COLUMN `id`,
ADD COLUMN `name` INT NULL FIRST,
DROP PRIMARY KEY;
;

ALTER TABLE `movies`.`actors` 
ADD COLUMN `id` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
CHANGE COLUMN `` `name` VARCHAR(45) NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `movies`.`actors` 
ADD COLUMN `id` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `character_name` VARCHAR(45) NULL AFTER `name`,
CHANGE COLUMN `` `name` VARCHAR(45) NULL ,
ADD PRIMARY KEY (`id`);
;

-- Question 13
-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
Done

-- Question 14
-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating
ALTER TABLE `movies`.`movies` 
ADD COLUMN `MPAA_rating` VARCHAR(255) NULL AFTER `genres`;

UPDATE movie.movies
SET MPAA_rating = "3.0"
WHERE id=3 or id=4 or id=5 or id=6 or id=7

*************************************************************************************

-- Question 15 (With Joins)
-- Find all the ratings for the movie Godfather, show just the title and the rating
SELECT m.title, r.rating
FROM movies.movies m
LEFT JOIN movies.ratings r ON m.id = r.movie_id
WHERE m.title like "godfather, the%"

-- Question 16 (With Joins)
-- Order the previous objective by newest to oldest
SELECT m.title, r.rating, r.timestamp
FROM movies.movies m
LEFT JOIN movies.ratings r ON m.id = r.movie_id
WHERE m.title like "godfather, the%"
ORDER by r.timestamp DESC

-- Question 17 (With Joins)
-- Find the comedies from 2005 and get the title and imdbid from the links table
SELECT m.title, l.imdb_Id
FROM movies.movies m
LEFT JOIN movies.links l ON m.id = l.movie_id
WHERE m.genres like "%comedy%" and m.title like "%2005%"

-- Question 18 (With Joins)
-- Find all movies that have no ratings
SELECT m.title, r.rating
FROM movies.movies as m
LEFT JOIN movies.ratings r ON m.id = r.movie_id
WHERE id NOT IN (SELECT movie_id FROM movies.ratings);

*************************************************************************************

-- Question 19
-- Get the average rating for a movie
SELECT m.title, AVG (r.rating)
FROM movie.ratings r
LEFT JOIN movie.movies m ON m.id=r.movie_id
GROUP BY m.title

-- Question 20
-- Get the total ratings for a movie
SELECT m.title, count(r.movie_id) as Total_Ratings
FROM movies.ratings r
left join movies.movies m on m.id=r.movie_id
group by m.title

-- Question 21
-- Get the total movies for a genre
SELECT m.genres, count(m.genres) as "Total Movies" FROM movies.movies m 
group by m.genres;

-- Question 22
-- Get the average rating for a user
SELECT r.user_id, avg(r.rating) FROM movies.ratings r
group by r.user_id;

-- Question 23
-- Find the user with the most ratings
SELECT r.user_id as User, COUNT(r.rating) as Rating
FROM  movies.ratings r
group by r.user_id 
order by Rating DESC
LIMIT 1;

-- Question 24
---Find the user with the highest average rating
SELECT r.user_id as User, avg(r.rating) as Highest_Average_Rating	
FROM movies.ratings r
GROUP BY r.user_id
ORDER BY Highest_Average_Rating DESC
LIMIT 1

-- Question 25
---Find the user with the highest average rating with more than 50 reviews
SELECT AVG(rating) Average_Rating, user_id as User, COUNT(rating) Number_Of_Reviews
FROM movies.ratings
GROUP BY User
HAVING Number_Of_Reviews > 50
ORDER BY Average_Rating DESC
LIMIT 1;

-- Question 26
-- Find the movies with an average rating over 4
SELECT AVG(rating) Average_Rating, title as Title
FROM movies.ratings
INNER JOIN movies.movies
ON movies.movies.id = movies.ratings.movie_id
GROUP BY title
HAVING Average_Rating > 4
ORDER BY Average_Rating DESC;

*************************************************************************************

Hard Mode

-- Question 27
Use concat and research about internet movie database to produce a valid url from the imdbid
SELECT m.title as TITLE, CONCAT("https://www.imdb.com/title/tt", l.imdb_Id) as URL
FROM movies.links l
left join movies.movies m on m.id=l.movie_id;

-- Question 28
Use concat and research about the movie database to produce a valid url from tmdbid
SELECT m.title as TITLE, concat("https://www.themoviedb.org/movie/", l.tmdb_Id) as URL
FROM movies.links l
left join movies.movies m on m.id=l.movie_id ;

-- Question 29
Get the ratings for The Unusuals and convert the timestamp into a human readable date time

-- Question 30
Using SQL normalize the tags in the tags table. Make them lowercased and replace the spaces with -

-- Question 31
Create a new field on the movies table for the year. Using an update query and a substring method update that column for every movie with the year found in the title column.

-- Question 32
Once you have completed the new year column go through the title column and strip out the year.

-- Question 33
Create a new column in the movies table and store the average review for each and every movie.