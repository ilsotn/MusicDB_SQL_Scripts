-- 02_insert_data.sql
-- Script to insert data into the tables in the MusicDB database

USE MusicDB;
GO

-- Insert data into Artists table
INSERT INTO Artists (ArtistName, Country) VALUES
('Talking Heads', 'USA'),
('King Crimson', 'UK'),
('Black Sabbath', 'UK'),
('Radiohead', 'USA'),
('Artist A', 'USA'),
('Artist B', 'UK');

-- Insert data into Albums table
INSERT INTO Albums (AlbumName, ReleaseYear, AlbumGenre, ArtistID) VALUES
('Remain in Light', 1980, 'New Wave', 1),
('In the Court of the Crimson King', 1969, 'Art Rock', 2),
('Paranoid', 1970, 'Heavy Metal', 3),
('In Rainbows', 2007, 'Art Rock', 4),
('Speaking in Tongues', 1983, 'New Wave', 1),
('Album A', 2024, 'Genre 1', 5),
('Album B', 2025, 'Genre 2', 5);

-- Insert more data into Albums table without specifying the genre
INSERT INTO Albums (AlbumName, ReleaseYear, ArtistID) VALUES
('Remain in Light', 1980, 1),
('Remain in Light 2', 1980, 1),
('In Rainbows 2', 2007, 4);

-- Enable identity insert for Songs table
SET IDENTITY_INSERT Songs ON;

-- Insert data into Songs table
INSERT INTO Songs (SongID, SongName, Duration) VALUES
(101, 'Born Under Punches', 330),
(102, 'Crosseyed and Painless', 340),
(103, 'The Great Curve', 370),
(104, 'Once in a Lifetime', 260),
(105, 'Houses in Motion', 320),
(106, 'Seen and Not Seen', 245),
(107, 'Listening Wind', 300),
(108, 'The Overload', 330),
(201, '21st Century Schizoid Man', 420),
(202, 'I Talk to the Wind', 360),
(203, 'Epitaph', 350),
(204, 'Moonchild', 720),
(205, 'The Court of the Crimson King', 540),
(301, 'War Pigs', 470),
(302, 'Paranoid', 170),
(303, 'Planet Caravan', 270),
(304, 'Iron Man', 360),
(305, 'Electric Funeral', 240),
(306, 'Hand of Doom', 430),
(307, 'Rat Salad', 140),
(308, 'Fairies Wear Boots', 370),
(401, '15 Step', 250),
(402, 'Bodysnatchers', 230),
(403, 'Nude', 270),
(404, 'Weird Fishes/Arpeggi', 330),
(405, 'All I Need', 210),
(406, 'Faust Arp', 150),
(407, 'Reckoner', 260),
(408, 'House of Cards', 330),
(409, 'Jigsaw Falling into Place', 250),
(410, 'Videotape', 240),
(501, 'Burning Down the House', 270),
(502, 'Making Flippy Floppy', 260),
(503, 'Girlfriend Is Better', 290),
(504, 'Slippery People', 320),
(505, 'I Get Wild/Wild Gravity', 310),
(506, 'Swamp', 280),
(507, 'Moon Rocks', 240),
(508, 'Pull Up the Roots', 270),
(509, 'This Must Be the Place (Naive Melody)', 290);

-- Disable identity insert for Songs table
SET IDENTITY_INSERT Songs OFF;

-- Insert data into AlbumSongs table (junction table)
INSERT INTO AlbumSongs (AlbumID, SongID) VALUES
(1, 101), (1, 102), (1, 103), (1, 104), (1, 105), (1, 106), (1, 107), (1, 108),
(2, 201), (2, 202), (2, 203), (2, 204), (2, 205),
(3, 301), (3, 302), (3, 303), (3, 304), (3, 305), (3, 306), (3, 307), (3, 308),
(4, 401), (4, 402), (4, 403), (4, 404), (4, 405), (4, 406), (4, 407), (4, 408), (4, 409), (4, 410),
(5, 501), (5, 502), (5, 503), (5, 504), (5, 505), (5, 506), (5, 507), (5, 508), (5, 509);

-- Insert data into SongArtists table (junction table)
INSERT INTO SongArtists (SongID, ArtistID) VALUES
(101, 1), (102, 1), (103, 1), (104, 1), (105, 1), (106, 1), (107, 1), (108, 1),
(201, 2), (202, 2), (203, 2), (204, 2), (205, 2),
(301, 3), (302, 3), (303, 3), (304, 3), (305, 3), (306, 3), (307, 3), (308, 3),
(401, 4), (402, 4), (403, 4), (404, 4), (405, 4), (406, 4), (407, 4), (408, 4), (409, 4), (410, 4),
(501, 1), (502, 1), (503, 1), (504, 1), (505, 1), (506, 1), (507, 1), (508, 1), (509, 1);

-- Insert data into Playlists table
INSERT INTO Playlists (PlaylistName, CreatedDate) VALUES
('Playlist 1', '2023-01-01'),
('Playlist 2', '2023-02-01');

-- Insert data into PlaylistSongs table (junction table)
INSERT INTO PlaylistSongs (PlaylistID, SongID) VALUES
(1, 101), (1, 201), (1, 301), (1, 401), (1, 501), (2, 105), (2, 205), (2, 305), (2, 405), (2, 505);
