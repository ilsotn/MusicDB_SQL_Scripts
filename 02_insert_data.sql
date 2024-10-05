-- 02_insert_data.sql
-- Script to insert data into the tables in the MusicDB database

USE MusicDB;
GO

INSERT INTO Artists (ArtistName) VALUES
('Unknown Artist');

-- Insert data into Artists table
INSERT INTO Artists (ArtistName, Country) VALUES
('Talking Heads', 'USA'),
('King Crimson', 'UK'),
('Black Sabbath', 'UK'),
('Radiohead', 'USA'),
('Pink Floyd', 'UK'),
('The Rolling Stones', 'UK'),
('Led Zeppelin', 'UK'),
('The Beatles', 'UK'),
('David Bowie', 'UK'),
('Nirvana', 'USA'),
('System of a Down', 'USA'),
('MF DOOM', 'USA'),
('Aphex Twin', 'UK'),
('Boards of Canada', 'UK');

SELECT * FROM Artists

INSERT INTO Genres (GenreName) 
VALUES 
    ('No genre'), -- 1
    ('New Wave'), -- 2
    ('Art Rock'), -- 3
    ('Heavy Metal'), -- 4
    ('Post-Punk'), -- 5
    ('Alternative Rock'), -- 6
    ('Classic Rock'), -- 7
    ('Progressive Rock'), -- 8
    ('Psychedelic Rock'), -- 9
    ('Folk Rock'), -- 10
    ('Hard Rock'), -- 11
    ('Blues Rock'), -- 12
    ('Jazz Rock'), -- 13
    ('Pop Rock'), -- 14
    ('Glam Rock'), -- 15
    ('Indie Rock'), -- 16
    ('Garage Rock'), -- 17
    ('Punk Rock'), -- 18
    ('Grunge'), -- 19
    ('Emo'), -- 20
    ('Shoegaze'), -- 21
    ('Post-Rock'), -- 22
    ('Synthpop'), -- 23
    ('Dream Pop'), -- 24
    ('Britpop'), -- 25
    ('Funk'), -- 26
    ('Disco'), -- 27
    ('Soul'), -- 28
    ('R&B'), -- 29
    ('Hip Hop'), -- 30
    ('Trap'), -- 31
    ('Reggae'), -- 32
    ('Ska'), -- 33
    ('Dub'), -- 34
    ('Dancehall'), -- 35
    ('Country'), -- 36
    ('Bluegrass'), -- 37
    ('Americana'), -- 38
    ('Gospel'), -- 39
    ('Electronic'), -- 40
    ('House'), -- 41
    ('Techno'), -- 42
    ('Trance'), -- 43
    ('Drum and Bass'), -- 44
    ('Ambient'), -- 45
    ('Downtempo'), -- 46
    ('Industrial'), -- 47
    ('K-Pop'), -- 48
    ('J-Pop'), -- 49
    ('World Music'), -- 50
	('Nu Metal'), -- 51
	('IDM'), -- 52
	('Ambient'), --53
	('Drill and Bass'); --54
GO

SELECT * FROM Genres

INSERT INTO Albums (AlbumName, ReleaseYear, GenreID, ArtistID, MonthlyListeners) VALUES
-- Talking Heads albums
('Remain in Light', 1980, 2, 2, 300000),      -- New Wave
('Speaking in Tongues', 1983, 2, 2, 250000),  -- New Wave
('Fear of Music', 1979, 2, 2, 200000),       -- New Wave

-- King Crimson albums
('In the Court of the Crimson King', 1969, 3, 3, 1500000), -- Art Rock
('Red', 1974, 3, 3, 1000000),                  -- Art Rock
('Larks Tongues in Aspic', 1973, 3, 3, 800000),      -- Art Rock
('Starless and Bible Black', 1974, 3, 3, 600000),     -- Art Rock

-- Black Sabbath albums
('Paranoid', 1970, 4, 4, 1800000),             -- Heavy Metal
('Master of Reality', 1971, 4, 4, 1500000),    -- Heavy Metal
('Sabbath Bloody Sabbath', 1973, 4, 4, 1200000), -- Heavy Metal
('Heaven and Hell', 1980, 4, 4, 1100000),      -- Heavy Metal

-- Radiohead albums
('In Rainbows', 2007, 3, 5, 2000000),          -- Art Rock
('Kid A', 2000, 6, 5, 1800000),                -- Alternative Rock
('Amnesiac', 2001, 6, 5, 1600000),             -- Alternative Rock

-- Pink Floyd albums
('The Dark Side of the Moon', 1973, 8, 6, 3000000), -- Progressive Rock
('Wish You Were Here', 1975, 8, 6, 2500000),  -- Progressive Rock
('The Wall', 1979, 8, 6, 2800000),            -- Progressive Rock

-- The Rolling Stones albums
('Sticky Fingers', 1971, 7, 7, 2200000),      -- Classic Rock
('Exile on Main St.', 1972, 7, 7, 2100000),   -- Classic Rock
('Let It Bleed', 1969, 7, 7, 1900000),        -- Classic Rock

-- Led Zeppelin albums
('Led Zeppelin IV', 1971, 11, 8, 1800000),      -- Hard Rock
('Houses of the Holy', 1973, 11, 8, 1700000),  -- Hard Rock
('Physical Graffiti', 1975, 11, 8, 1600000),   -- Hard Rock

-- The Beatles albums
('Abbey Road', 1969, 7, 9, 3000000),           -- Classic Rock
('Let It Be', 1970, 7, 9, 2800000),            -- Classic Rock
('Sgt. Peppers Lonely Hearts Club Band', 1967, 7, 9, 3200000), -- Classic Rock

-- David Bowie albums
('The Rise and Fall of Ziggy Stardust and the Spiders from Mars', 1972, 15, 10, 1700000), -- Glam Rock
('Hunky Dory', 1971, 15, 10, 1600000),         -- Glam Rock
('Low', 1977, 15, 10, 1500000),                -- Glam Rock

-- Nirvana albums
('Nevermind', 1991, 19, 11, 2000000),          -- Grunge
('In Utero', 1993, 19, 11, 1800000),           -- Grunge
('MTV Unplugged in New York', 1994, 19, 11, 1700000), -- Grunge

-- System of a Down albums
('System of a Down', 1998, 51, 12, 800000),   -- Nu Metal
('Toxicity', 2001, 51, 12, 1000000),           -- Nu Metal
('Steal This Album!', 2002, 51, 12, 900000),  -- Nu Metal

-- MF DOOM albums
('MM..FOOD', 2004, 30, 13, 500000),          -- Hip Hop
('Madvillainy', 2004, 30, 13, 300000), -- Hip Hop
('Born Like This', 2009, 30, 13, 400000),     -- Hip Hop

-- Aphex Twin albums
('Selected Ambient Works 85-92', 1992, 53, 14, 600000), -- Ambient
('Richard D. James Album', 1996, 52, 14, 500000),       -- IDM
('Drukqs', 2001, 54, 14, 400000),					    -- Drill and Bass

-- Boards of Canada albums
('Music Has the Right to Children', 1998, 52, 15, 350000),  -- IDM
('Geogaddi', 2002, 52, 15, 300000),                         -- IDM
('The Campfire Headphase', 2005, 52, 15, 250000);          -- IDM



SELECT * FROM Albums

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
