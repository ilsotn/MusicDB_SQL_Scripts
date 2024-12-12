
IF OBJECT_ID('#AlbumsByYear', 'U') IS NOT NULL DROP TABLE AlbumsByYear;

ALTER PROCEDURE GetAlbumsByArtistAndYear
    @artistName NVARCHAR(100),
    @releaseYear SMALLINT
AS
BEGIN
    DECLARE @albumList NVARCHAR(MAX);
    SET @albumList = '';

    SELECT @albumList = STUFF((
        SELECT ', ' + A.AlbumName
        FROM Albums A
        JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
        WHERE Ar.ArtistName = @artistName AND A.ReleaseYear = @releaseYear
        FOR XML PATH('')), 1, 2, '');

    IF @albumList IS NOT NULL AND @albumList != ''
        PRINT @albumList;
    ELSE
        PRINT '-';
END;


EXEC GetAlbumsByArtistAndYear 'MF DOOM', 2004;

CREATE TABLE AlbumsSummary (
    ArtistName NVARCHAR(100),
    [1965] NVARCHAR(MAX),
    [1966] NVARCHAR(MAX),
    [1967] NVARCHAR(MAX),
    [1968] NVARCHAR(MAX),
    [1969] NVARCHAR(MAX),
    [1970] NVARCHAR(MAX),
    [1971] NVARCHAR(MAX),
    [1972] NVARCHAR(MAX),
    [1973] NVARCHAR(MAX),
    [1974] NVARCHAR(MAX),
    [1975] NVARCHAR(MAX),
    [1976] NVARCHAR(MAX),
    [1977] NVARCHAR(MAX),
    [1978] NVARCHAR(MAX),
    [1979] NVARCHAR(MAX),
    [1980] NVARCHAR(MAX),
    [1981] NVARCHAR(MAX),
    [1982] NVARCHAR(MAX),
    [1983] NVARCHAR(MAX),
    [1984] NVARCHAR(MAX),
    [1985] NVARCHAR(MAX),
    [1986] NVARCHAR(MAX),
    [1987] NVARCHAR(MAX),
    [1988] NVARCHAR(MAX),
    [1989] NVARCHAR(MAX),
    [1990] NVARCHAR(MAX),
    [1991] NVARCHAR(MAX),
    [1992] NVARCHAR(MAX),
    [1993] NVARCHAR(MAX),
    [1994] NVARCHAR(MAX),
    [1995] NVARCHAR(MAX),
    [1996] NVARCHAR(MAX),
    [1997] NVARCHAR(MAX),
    [1998] NVARCHAR(MAX),
    [1999] NVARCHAR(MAX),
    [2000] NVARCHAR(MAX),
    [2001] NVARCHAR(MAX),
    [2002] NVARCHAR(MAX),
    [2003] NVARCHAR(MAX),
    [2004] NVARCHAR(MAX),
    [2005] NVARCHAR(MAX),
    [2006] NVARCHAR(MAX),
    [2007] NVARCHAR(MAX),
    [2008] NVARCHAR(MAX),
    [2009] NVARCHAR(MAX),
    [2010] NVARCHAR(MAX),
    [2011] NVARCHAR(MAX),
    [2012] NVARCHAR(MAX),
    [2013] NVARCHAR(MAX),
    [2014] NVARCHAR(MAX),
    [2015] NVARCHAR(MAX)
);

DECLARE artistCursor CURSOR FOR
SELECT ArtistName
FROM Artists;

DECLARE @artistName NVARCHAR(100);
DECLARE @albumList NVARCHAR(MAX);
DECLARE @year SMALLINT;

OPEN artistCursor;

FETCH NEXT FROM artistCursor INTO @artistName;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO AlbumsSummary (ArtistName)
    VALUES (@artistName);

    SET @year = 1965;
    WHILE @year <= 2015
    BEGIN
        EXEC GetAlbumsByArtistAndYear @artistName, @year;

        SET @albumList = (SELECT ISNULL(STUFF((
            SELECT ', ' + A.AlbumName
            FROM Albums A
            JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
            WHERE Ar.ArtistName = @artistName AND A.ReleaseYear = @year
            FOR XML PATH('')), 1, 2, ''), '-'));

        DECLARE @sql NVARCHAR(MAX);
        SET @sql = 'UPDATE AlbumsSummary SET [' + CAST(@year AS NVARCHAR) + '] = @albumList WHERE ArtistName = @artistName';
        EXEC sp_executesql @sql, N'@albumList NVARCHAR(MAX), @artistName NVARCHAR(100)', @albumList, @artistName;

        SET @year = @year + 1;
    END;

    FETCH NEXT FROM artistCursor INTO @artistName;	
END;

CLOSE artistCursor;
DEALLOCATE artistCursor;

SELECT * FROM AlbumsSummary;
