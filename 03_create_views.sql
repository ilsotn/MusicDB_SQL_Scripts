-- 03_create_views.sql
-- Script to create views in the MusicDB database

USE MusicDB;
GO

-- Create a view to list all songs with album and artist details
CREATE VIEW SongDetails AS
SELECT 
    Songs.SongID, 
    Songs.SongName, 
    Albums.AlbumName, 
    Artists.ArtistName, 
    Songs.Duration 
FROM Songs
INNER JOIN AlbumSongs ON Songs.SongID = AlbumSongs.SongID
INNER JOIN Albums ON AlbumSongs.AlbumID = Albums.AlbumID
INNER JOIN SongArtists ON Songs.SongID = SongArtists.SongID
INNER JOIN Artists ON SongArtists.ArtistID = Artists.ArtistID;

-- Create a view to list all playlists with song details
CREATE VIEW PlaylistDetails AS
SELECT 
    Playlists.PlaylistID, 
    Playlists.PlaylistName, 
    Songs.SongID, 
    Songs.SongName 
FROM Playlists
INNER JOIN PlaylistSongs ON Playlists.PlaylistID = PlaylistSongs.PlaylistID
INNER JOIN Songs ON PlaylistSongs.SongID = Songs.SongID;
