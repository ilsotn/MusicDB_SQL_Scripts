	USE MusicDB;
GO

-- 1. Add two new albums ("More Songs About Buildings and Food" and "OK Computer")
EXEC spCreateAlbum 
    @AlbumName = 'More Songs About Buildings and Food1', 
    @ReleaseYear = 1978, 
    @ArtistID = 2, 
    @GenreName  = 'NewGenre1';
GO

EXEC spCreateAlbum 
    @AlbumName = 'OK Computer',	
    @ReleaseYear = 1997, 
    @ArtistID = 5, 
    @GenreID  = 6;
GO

SELECT * FROM Albums

-- 2. Retrieve all albums (excluding soft-deleted ones)
EXEC spGetAlbums

-- 3. Update Remain in Light's genre to "Post-Punk"
EXEC spUpdateAlbum 
    @AlbumID = 1, 
    @AlbumGenre = 'Post-Punk';
GO

-- 4. Soft delete "In the Court of the Crimson King"
EXEC spDeleteAlbum @AlbumID = 2;
GO

-- 5. Verify the soft deletion of "In the Court of the Crimson King" and the update of "Remain in Light" genre
EXEC spGetAlbums @ShowDeleted = 0;
GO

-- 6. Retrieve all albums (including the soft-deleted one)
EXEC spGetAlbums @ShowDeleted = 1;
GO

-- 7. Restore the soft-deleted "In the Court of the Crimson King"
EXEC spRestoreAlbum @AlbumID = 2;
GO

-- 8. Verify the restoration of "In the Court of the Crimson King"
EXEC spGetAlbums @ShowDeleted = 0;
GO

-- 9. Attempt to soft delete an album that doesn't exist
EXEC spDeleteAlbum @AlbumID = 999;
GO

-- 10. Attempt to soft delete an album that's already deleted
EXEC spDeleteAlbum @AlbumID = 2;
GO
EXEC spDeleteAlbum @AlbumID = 2;
GO

-- 11. Attempt to restore an album that doesn't exist (AlbumID = 999)
EXEC spRestoreAlbum @AlbumID = 999;
GO

-- 12. Attempt to restore an album that has not been soft deleted (AlbumID = 1, which has not been deleted)
EXEC spRestoreAlbum @AlbumID = 2;
GO

EXEC spGetAlbums @PageNumber = 1;
EXEC spGetAlbums @PageNumber = 33;
EXEC spGetAlbums @ArtistName = 'Talking', @StartYear = 1970, @EndYear = 1980;
EXEC spGetAlbums @GenreName = 'Metal';
EXEC spGetAlbums @MinMonthlyListeners = 2000000, @MaxMonthlyListeners = 3000000;
EXEC spGetAlbums @MaxMonthlyListeners = 300000;

SELECT * FROM Genres
