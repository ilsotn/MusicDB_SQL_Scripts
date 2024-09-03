-- 04_queries.sql
-- Script to run sample queries against the MusicDB database

USE MusicDB;
GO

-- Retrieve all songs with their album and artist details
SELECT * FROM SongDetails;

-- Retrieve all playlists with their song details
SELECT * FROM PlaylistDetails;

-- Retrieve all albums by a specific artist
SELECT AlbumName FROM Albums WHERE ArtistID = 1;

-- Retrieve all songs from a specific album
SELECT SongName FROM Songs
INNER JOIN AlbumSongs ON Songs.SongID = AlbumSongs.SongID
WHERE AlbumID = 1;

-- Retrieve all songs in a specific playlist
SELECT SongName FROM Songs
INNER JOIN PlaylistSongs ON Songs.SongID = PlaylistSongs.SongID
WHERE PlaylistID = 1;

-- Count the number of songs in each playlist
SELECT PlaylistID, COUNT(SongID) AS NumberOfSongs 
FROM PlaylistSongs 
GROUP BY PlaylistID;
