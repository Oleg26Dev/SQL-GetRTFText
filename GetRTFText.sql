/*
	Written by:		win32nipuh@gmail.com
	Created On:		2022-10-01
*/
DROP FUNCTION IF EXISTS dbo.[GetRTFText]
go
CREATE FUNCTION [dbo].[GetRTFText](@data nvarchar(max)) RETURNS nvarchar(max)
AS
BEGIN
  DECLARE @pn1 int=0, @pn2 int=0;
  DECLARE @hex varchar(316);
  DECLARE @tb table (ch char(1),position int);

INSERT @tb(ch, position ) SELECT SUBSTRING(@data, [Number], 1), [Number]  FROM [master]..[spt_values] WHERE ([Type] = 'p') AND (SUBSTRING(@data, Number, 1) IN ('{', '}'));
SELECT @pn1 = MIN(position), @pn2 = MAX(position) FROM @tb;
DELETE FROM @tb WHERE (position IN (@pn1, @pn2));

WHILE (1 = 1)
BEGIN
	SELECT TOP 1 @pn1 = s1.position, @pn2 = s2.position 
	FROM @tb s1
	INNER JOIN @tb s2 ON s2.position > s1.position
	WHERE (s1.ch = '{') AND (s2.ch = '}')
	ORDER BY s2.position - s1.position;
	IF @@ROWCOUNT = 0 BREAK
	DELETE FROM @tb WHERE (position IN (@pn1, @pn2));
	UPDATE @tb SET position = position - @pn2 + @pn1 - 1  WHERE (position > @pn2);
	SET @data = STUFF(@data, @pn1, @pn2 - @pn1 + 1, '');
END

SET @data = REPLACE(@data, '{\rtf1\ansi{\fonttbl{\f0 MS Sans Serif;}}', '');
SET @data = REPLACE(REPLACE(@data, '\pard', ''), '\par', '');
SET @data = STUFF(@data, 1, 1, '');
SET @data = REPLACE(@data, N'\line', ' '); -- added linebreak 
SET @data = STUFF(@data, 1, CHARINDEX(' ', @data), '');
SET @data = REPLACE(REPLACE(@data, '\ulnone', ''), '\ul', '');
SET @data = REPLACE(@data, '{', '');
SET @data = REPLACE(@data, 'Msftedit 5.41.21.2510;}', '');
SET @data = REPLACE(REPLACE(@data, '\ldblquote', '"'), '\rdblquote', '"');
SET @data = REPLACE(REPLACE(@data, '\lquote', ''''), '\rquote', '''');
SET @data = REPLACE(@data, '\bullet', '');
SET @data = REPLACE(REPLACE(@data, '\endash', ''), '\emdash', '');
SET @data = REPLACE(REPLACE(@data, '\enspace', ''), '\emspace', '');

WHILE (LEN(@data) = 0 OR RIGHT(@data, 1) IN (' ', CHAR(13), CHAR(10), '}')) BEGIN   SELECT @data = SUBSTRING(@data, 1, (LEN(@data + 'x') - 2)); END

SET @pn1 = CHARINDEX('\''', @data);

WHILE @pn1 > 0
BEGIN
        SET @hex = '0x' + SUBSTRING(@data, @pn1 + 2, 2); SET @data = REPLACE(@data, SUBSTRING(@data, @pn1, 4), CHAR(CONVERT(int, CONVERT (binary(1), @hex,1))));
        SET @pn1 = CHARINDEX('\''', @data);
END

SET @data = @data + ' ';
SET @pn1 = PATINDEX('%\%[0123456789][\ ]%', @data);

WHILE @pn1 > 0
BEGIN
    SET @pn2 = CHARINDEX(' ', @data, @pn1 + 1); IF @pn2 < @pn1 SET @pn2 = CHARINDEX('\', @data, @pn1 + 1);
    IF @pn2 < @pn1
    BEGIN
        SET @data = SUBSTRING(@data, 1, @pn1 - 1); SET @pn1 = 0;
    END
    ELSE
    BEGIN
        SET @data = STUFF(@data, @pn1, @pn2 - @pn1 + 1, '');
        SET @pn1 = PATINDEX('%\%[0123456789][\ ]%', @data);
    END
END

IF RIGHT(@data, 1) = ' ' SET @data = SUBSTRING(@data, 1, LEN(@data) -1);

RETURN @data;
END
GO
GRANT EXEC On dbo.GetRTFText to PUBLIC;
GO
