-- 01_create_tables.sql
-- Script to create tables in the MusicDB database

USE MusicDB;
GO

-- Drop existing tables if they exist
IF OBJECT_ID('PlaylistSongs', 'U') IS NOT NULL DROP TABLE PlaylistSongs;
IF OBJECT_ID('Playlists', 'U') IS NOT NULL DROP TABLE Playlists;
IF OBJECT_ID('SongArtists', 'U') IS NOT NULL DROP TABLE SongArtists;
IF OBJECT_ID('AlbumSongs', 'U') IS NOT NULL DROP TABLE AlbumSongs;
IF OBJECT_ID('Songs', 'U') IS NOT NULL DROP TABLE Songs;
IF OBJECT_ID('Albums', 'U') IS NOT NULL DROP TABLE Albums;
IF OBJECT_ID('Artists', 'U') IS NOT NULL DROP TABLE Artists;

-- Create Artists table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY IDENTITY,
    ArtistName NVARCHAR(100) NOT NULL,
    Country CHAR(3) DEFAULT 'UNK'
);

-- Create Albums table
CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY IDENTITY,
    AlbumName NVARCHAR(100) NOT NULL,
    ReleaseYear SMALLINT DEFAULT YEAR(GETDATE()), 
    ArtistID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- Add AlbumGenre column to Albums table
ALTER TABLE Albums 
ADD AlbumGenre NVARCHAR(50) DEFAULT 'No genre';

-- Create Songs table
CREATE TABLE Songs (
    SongID INT PRIMARY KEY IDENTITY,
    SongName VARCHAR(100) NOT NULL,
    Duration SMALLINT DEFAULT NULL
);

-- Create AlbumSongs table (junction table between Albums and Songs)
CREATE TABLE AlbumSongs (
    AlbumID INT,
    SongID INT,
    PRIMARY KEY (AlbumID, SongID),
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Create SongArtists table (junction table between Songs and Artists)
CREATE TABLE SongArtists (
    SongID INT,
    ArtistID INT,
    PRIMARY KEY (SongID, ArtistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Create Playlists table
CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY IDENTITY,
    PlaylistName NVARCHAR(100) NOT NULL,
    CreatedDate DATE DEFAULT GETDATE()
);

-- Create PlaylistSongs table (junction table between Playlists and Songs)
CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
