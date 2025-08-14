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


--===========================================================================
-- 7. Find the top 5 tracks with the highest energy values.
--===========================================================================


--===========================================================================
-- 8. List all tracks along with their views and likes where official_video = TRUE.
--===========================================================================


--===========================================================================
-- 9. For each album, calculate the total views of all associated tracks.
--===========================================================================


--===========================================================================
-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
--===========================================================================



