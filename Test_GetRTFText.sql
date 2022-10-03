declare @rtf nvarchar(4000)=
N'{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Calibri;}{\f1\fnil\fcharset204 Calibri;}}
{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\sa200\sl276\slmult1\lang9\f0\fs22 The \ldblquote\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote characters are displayed/saved as \ldblquote\lang1058\f1\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote \lang9\f0\par
The \lang1049\f1 \''d9 \lang9\f0\''fc\lang1049\f1 \lang9\f0\ldblquote\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote characters are displayed/saved as \ldblquote\lang1058\f1\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote \par
\lang9\f0\par
}'
SELECT dbo.GetRTFText(@rtf)
GO
declare @rtf nvarchar(4000)=
N'{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Calibri;}{\f1\fnil\fcharset204 Calibri;}}
{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\sa200\sl276\slmult1\lang9\f0\fs22 The \ldblquote\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote якась фігня characters are displayed/saved as \ldblquote\lang1058\f1\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote \lang9\f0\par
The \lang1049\f1 \''d9 \lang9\f0\''fc\lang1049\f1 \lang9\f0\ldblquote\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote characters are displayed/saved as \ldblquote\lang1058\f1\''fc\rdblquote , \ldblquote\''f6\rdblquote , \ldblquote\''e7\rdblquote \par
\lang9\f0\par
}'

SELECT dbo.GetRTFText(@rtf)
GO
