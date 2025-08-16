--======================================================================
-- Create table's header
--======================================================================
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT
COUNT(*) 
FROM spotify

/*
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.
*/

--===========================================================================
-- 1. Retrieve the names of all tracks that have more than 1 billion streams.
--===========================================================================
SELECT
	track,
	stream
FROM spotify
WHERE stream > 1000000000

--===========================================================================
-- 2. List all albums along with their respective artists.
--===========================================================================
SELECT
	DISTINCT album,
	artist
FROM spotify

-- Detect row duplicate
SELECT
	album,
	COUNT(album)
FROM spotify
GROUP BY album

-- Calling data contains row duplicate
SELECT
	*
FROM spotify
WHERE album = 'Acústico (Ao Vivo / Deluxe)'

--===========================================================================
-- 3. Get the total number of comments for tracks where licensed = TRUE.
--===========================================================================
SELECT
	SUM(comments)
FROM spotify
WHERE licensed = 'true'

--===========================================================================
-- 4. Find all tracks that belong to the album type single.
--===========================================================================
SELECT
	track
FROM spotify
WHERE album_type = 'single'

--===========================================================================
-- 5. Count the total number of tracks by each artist.
--===========================================================================
SELECT
	artist,
	COUNT(track)
FROM spotify
GROUP BY artist

/*
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/
--===========================================================================
-- 6. Calculate the average danceability of tracks in each album.
--===========================================================================
SElECT
	album,
	AVG(danceability) as average_danceability
FROM spotify
GROUP by album

--===========================================================================
-- 7. Find the top 5 tracks with the highest energy values.
--===========================================================================
SELECT
	track,
	energy
FROM spotify
ORDER BY energy DESC
LIMIT 5

--=================================================================================
-- 8. List all tracks along with their views and likes where official_video = TRUE.
--=================================================================================
SELECT
	track,
	views,
	likes
FROM spotify
WHERE official_video = 'true'

--===========================================================================
-- 9. For each album, calculate the total views of all associated tracks.
--===========================================================================
SELECT
	album,
	SUM(views) as total_views
FROM spotify
GROUP BY album

--===================================================================================
-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
--===================================================================================
SELECT
	track
FROM spotify
WHERE most_played_on = 'Spotify'

/*
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
*/
--===================================================================================
-- 11. Find the top 3 most-viewed tracks for each artist using window functions.
--===================================================================================
WITH CTE_rank_view AS (
SELECT
*,
ROW_number() OVER(PARTITION BY artist ORDER BY views DESC) as rank_views
FROM spotify
)
SELECT
artist,
track,
rank_views
FROM CTE_rank_view
WHERE rank_views IN (1,2,3)

--===================================================================================
-- 12. Write a query to find tracks where the liveness score is above the average.
--===================================================================================
WITH CTE_liveness AS (
SELECT
	*,
	AVG(liveness) OVER() as average_liveness
FROM spotify
)
SELECT
	track,
	liveness
FROM CTE_liveness
WHERE liveness > average_liveness


--===================================================================================
-- 13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
--===================================================================================
WITH CTE_energy AS (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY album ORDER BY energy) as ascending_energy,
ROW_Number() OVER(PARTITION BY album ORDER BY energy DESC) as descending_energy
FROM spotify
), CTE_minimum AS (
SELECT
track,
album,
energy AS minimum_energy
FROM CTE_energy
WHERE ascending_energy = 1
), CTE_maximum AS (
SELECT
track,
album,
energy AS maximum_energy
FROM CTE_energy
WHERE descending_energy = 1
)

SELECT
* 
FROM CTE_minimum

