USE MusicDB;
GO


-- CREATE ALBUM 
ALTER PROCEDURE spCreateAlbum
    @AlbumName NVARCHAR(100),
    @ReleaseYear SMALLINT = NULL,
    @ArtistName NVARCHAR(100),
    @MonthlyListeners INT = 0,
    @GenreName NVARCHAR(50) = NULL,
    @Country CHAR(3) = 'UNK',
    @AlbumCover VARBINARY(MAX) = NULL,  
    @AlbumID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;

        DECLARE @ArtistID INT;
        DECLARE @GenreID INT = 1;

        -- Check for duplicate album
        IF EXISTS (SELECT 1 FROM Albums WHERE AlbumName = @AlbumName AND ReleaseYear = ISNULL(@ReleaseYear, YEAR(GETDATE())) AND Deleted = 0)
        BEGIN
            RAISERROR('An album with the same name and release year already exists.', 16, 1);
            RETURN;
        END

        -- Handle Artist
        IF @ArtistName IS NOT NULL
        BEGIN
            SELECT @ArtistID = ArtistID 
            FROM Artists 
            WHERE ArtistName = @ArtistName AND Deleted = 0;

            IF @ArtistID IS NULL
            BEGIN
                INSERT INTO Artists (ArtistName, Country)
                VALUES (@ArtistName, @Country);

                SET @ArtistID = SCOPE_IDENTITY();
            END
        END
        ELSE
        BEGIN
            RAISERROR('ArtistName must be provided.', 16, 1);
            RETURN;
        END

        -- Handle Genre
        IF @GenreName IS NOT NULL
        BEGIN
            SELECT @GenreID = GenreID 
            FROM Genres 
            WHERE GenreName = @GenreName;

            IF @GenreID IS NULL
            BEGIN
                INSERT INTO Genres (GenreName)
                VALUES (@GenreName);

                SET @GenreID = SCOPE_IDENTITY();
            END
        END

        -- Insert the album
        INSERT INTO Albums (AlbumName, ReleaseYear, ArtistID, GenreID, MonthlyListeners, AlbumCover)
        VALUES (
            @AlbumName, 
            ISNULL(@ReleaseYear, YEAR(GETDATE())), 
            @ArtistID, 
            @GenreID, 
            @MonthlyListeners,
            CASE WHEN @AlbumCover IS NOT NULL THEN @AlbumCover ELSE NULL END
        );

        SET @AlbumID = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
CREATE PROCEDURE spDeleteSongFromAlbum
    @SongID INT,
    @AlbumID INT
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;

        -- Delete the association between the song and the album
        DELETE FROM AlbumSongs
        WHERE SongID = @SongID AND AlbumID = @AlbumID;

        -- Check if the song is still associated with any other album
        IF NOT EXISTS (SELECT 1 FROM AlbumSongs WHERE SongID = @SongID)
        BEGIN
            -- If not associated with any album, delete the song
            DELETE FROM Songs WHERE SongID = @SongID;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROCEDURE spAddSongToAlbum
    @AlbumID INT,
    @SongName NVARCHAR(100),
    @Duration INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SongID INT;

    -- Insert the song
    INSERT INTO Songs (SongName, Duration)
    VALUES (@SongName, @Duration);

    SET @SongID = SCOPE_IDENTITY();  -- Get the new SongID

    -- Link song to album in AlbumSongs table
    INSERT INTO AlbumSongs (AlbumID, SongID)
    VALUES (@AlbumID, @SongID);
END;
GO


-- GET ALBUMS with filtering options
ALTER PROCEDURE spGetAlbums
    @ShowDeleted BIT = 0,
    @ArtistName NVARCHAR(100) = NULL,
    @GenreName NVARCHAR(50) = NULL,
    @StartYear SMALLINT = NULL,
    @EndYear SMALLINT = NULL,
    @MinMonthlyListeners INT = NULL,  
    @MaxMonthlyListeners INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	SELECT 
		a.AlbumID,
		a.AlbumName, 
		a.ReleaseYear, 
		g.GenreName, 
		ar.ArtistName,	
		a.MonthlyListeners,
		a.AlbumCover
    FROM Albums a
        LEFT JOIN Artists ar ON a.ArtistID = ar.ArtistID
        LEFT JOIN Genres g ON a.GenreID = g.GenreID  -- Join with Genres table if GenreID is present
    WHERE (@ShowDeleted = 1 OR a.Deleted = 0)  -- Include deleted albums only if @ShowDeleted = 1
        AND (@ArtistName IS NULL OR ar.ArtistName LIKE '%' + @ArtistName + '%')  -- Filter by artist name if provided
        AND (@GenreName IS NULL OR g.GenreName LIKE '%' + @GenreName + '%')  -- Filter by genre name if provided
        AND (@StartYear IS NULL OR a.ReleaseYear >= @StartYear)  -- Filter by start year if provided
        AND (@EndYear IS NULL OR a.ReleaseYear <= @EndYear)  -- Filter by end year if provided
        AND (@MinMonthlyListeners IS NULL OR a.MonthlyListeners >= @MinMonthlyListeners)  -- Filter by minimum monthly listeners if provided
        AND (@MaxMonthlyListeners IS NULL OR a.MonthlyListeners <= @MaxMonthlyListeners);  -- Filter by maximum monthly listeners if provided
END;
GO



-- UPDATE ALBUM with GenreID and MonthlyListeners
ALTER PROCEDURE spUpdateAlbum
    @AlbumID INT,
    @AlbumName NVARCHAR(100),
    @ReleaseYear SMALLINT,
    @ArtistName NVARCHAR(100),
    @GenreName NVARCHAR(50),
    @MonthlyListeners INT,
    @AlbumCover VARBINARY(MAX) = NULL
AS
BEGIN
    BEGIN TRY
        -- Ensure the album exists
        IF NOT EXISTS (SELECT 1 FROM Albums WHERE AlbumID = @AlbumID)
        BEGIN
            RAISERROR('Album not found.', 16, 1);
            RETURN;
        END

        -- Get ArtistID and GenreID based on names
        DECLARE @ArtistID INT = NULL;
        DECLARE @GenreID INT = NULL;

        SELECT @ArtistID = ArtistID FROM Artists WHERE ArtistName = @ArtistName;
        SELECT @GenreID = GenreID FROM Genres WHERE GenreName = @GenreName;

        -- Update the album details, including conditional update for AlbumCover
        UPDATE Albums
        SET 
            AlbumName = @AlbumName,
            ReleaseYear = @ReleaseYear,
            ArtistID = ISNULL(@ArtistID, ArtistID),
            GenreID = ISNULL(@GenreID, GenreID),
            MonthlyListeners = @MonthlyListeners,
            AlbumCover = CASE WHEN @AlbumCover IS NOT NULL THEN @AlbumCover ELSE AlbumCover END
        WHERE AlbumID = @AlbumID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

CREATE PROCEDURE spGetAlbumByID
    @AlbumID INT
AS
BEGIN
    DECLARE @RecordCount INT;

    SELECT @RecordCount = COUNT(*)
    FROM Albums
    WHERE AlbumID = @AlbumID;

    -- Check if no records were found
    IF @RecordCount = 0
    BEGIN
        -- Raise an error if no matching record is found
        RAISERROR('No album found with the specified AlbumID: %d', 16, 1, @AlbumID);
        RETURN;
    END

    -- If a record exists, retrieve the Album details
    SELECT AlbumName, AlbumCover
    FROM Albums
    WHERE AlbumID = @AlbumID;
END;


-- SOFT DELETE ALBUM
ALTER PROCEDURE spDeleteAlbum
    @AlbumID INT
AS
BEGIN
    -- Check if the album exists and hasn't been deleted
    IF EXISTS (SELECT 1 FROM Albums WHERE AlbumID = @AlbumID AND Deleted = 0)
    BEGIN
        -- Soft delete the album by setting the Deleted status to 1
        UPDATE Albums
        SET Deleted = 1
        WHERE AlbumID = @AlbumID;
    END
    ELSE
    BEGIN
        RAISERROR('Album not found or already deleted.', 16, 1);
    END
END;
GO


-- RESTORE ALBUM
ALTER PROCEDURE spRestoreAlbum
    @AlbumID INT
AS
BEGIN
    -- Check if the album exists and has been deleted
    IF EXISTS (SELECT 1 FROM Albums WHERE AlbumID = @AlbumID AND Deleted = 1)
    BEGIN
        -- Restore the album by setting the Deleted status back to 0
        UPDATE Albums
        SET Deleted = 0
        WHERE AlbumID = @AlbumID;
    END
    ELSE
    BEGIN
        RAISERROR('Album not found or is not deleted.', 16, 1);
    END
END;
GO

-- CREATE ARTIST
ALTER PROCEDURE spCreateArtist
    @ArtistName NVARCHAR(100),
    @Country CHAR(3) = 'UNK'
AS
BEGIN
    INSERT INTO Artists (ArtistName, Country)
    VALUES (@ArtistName, @Country);
END;
GO

-- GET ARTISTS with filtering options
ALTER PROCEDURE spGetArtists
    @ShowDeleted BIT = 0,
    @ArtistName NVARCHAR(100) = NULL,
    @Country CHAR(3) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 5
AS
BEGIN
    DECLARE @Offset INT;
    SET @Offset = (@PageNumber - 1) * @PageSize + 1;

    WITH PagedArtists AS
    (
        SELECT 
            ArtistID,
            ArtistName,
            Country,
            ROW_NUMBER() OVER (ORDER BY ArtistName ASC) AS RowNum
        FROM Artists
        WHERE (@ShowDeleted = 1 OR Deleted = 0)  -- Include deleted artists only if @ShowDeleted = 1
            AND (@ArtistName IS NULL OR ArtistName LIKE '%' + @ArtistName + '%')  -- Filter by artist name
            AND (@Country IS NULL OR Country = @Country)  -- Filter by country
    )
    SELECT * FROM PagedArtists
    WHERE RowNum BETWEEN @Offset AND (@Offset + @PageSize - 1);
END;
GO

-- UPDATE ARTIST
ALTER PROCEDURE spUpdateArtist
    @ArtistID INT,
    @ArtistName NVARCHAR(100) = NULL,
    @Country CHAR(3) = NULL
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Artists WHERE ArtistID = @ArtistID AND Deleted = 0)
    BEGIN
        UPDATE Artists
        SET
            ArtistName = ISNULL(@ArtistName, ArtistName),
            Country = ISNULL(@Country, Country)
        WHERE ArtistID = @ArtistID;
    END
    ELSE
    BEGIN
        RAISERROR('Artist not found or has been deleted.', 16, 1);
    END
END;
GO

-- SOFT DELETE ARTIST
ALTER PROCEDURE spDeleteArtist
    @ArtistID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Artists WHERE ArtistID = @ArtistID AND Deleted = 0)
    BEGIN
        UPDATE Artists
        SET Deleted = 1
        WHERE ArtistID = @ArtistID;
    END
    ELSE
    BEGIN
        RAISERROR('Artist not found or already deleted.', 16, 1);
    END
END;
GO

-- RESTORE ARTIST
ALTER PROCEDURE spRestoreArtist
    @ArtistID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Artists WHERE ArtistID = @ArtistID AND Deleted = 1)
    BEGIN
        UPDATE Artists
        SET Deleted = 0
        WHERE ArtistID = @ArtistID;
    END
    ELSE
    BEGIN
        RAISERROR('Artist not found or is not deleted.', 16, 1);
    END
END;
GO
USE MusicDB;
GO

SELECT * FROM Songs 


EXEC spGetAlbumByID -5
