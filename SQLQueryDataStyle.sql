/*----------------------------------------------------------------------------------
   資料型別
----------------------------------------------------------------------------------*/
--整數
declare @i bit
declare @j int
set @i=1
set @j=1234567890
SELECT datalength(@i) '佔用位元組',@i 'i'
select datalength(@j) '佔用位元組',@j 'j'
go 



--精確數 預設(18,0)
declare @i decimal(38)
declare @j numeric
declare @k numeric
set @i=12345678901234567890123456789012345678
set @j=123456789012345678
set @k=1234567895566
select datalength(@i) '佔用位元組',@i 'i'
SELECT datalength(@j) '佔用位元組',@j 'j'
SELECT datalength(@k) '佔用位元組',@k 'k'
go 



--float型別，n值為科學記號標記法，當 n=1~24 則 n=24，有效位數7位；當 n=25~53 則 n=53，有效位數15位
DECLARE @i float(5)
set @i=123456789012345
select datalength(@i) '佔用位元組',@i 'i'
go



--float(n)的 n 值預設為53
DECLARE @i float
set @i=12345678901234567890
select datalength(@i) '佔用位元組',@i 'i'
go



-- float最大的表示範圍1.79E+308
DECLARE @j float
--set @j=1.79E+308
set @j=1234567890123456
select datalength(@j) '佔用位元組',@j 'j'
go

--real型別，數值可以表示到7位數，即 real=folat(24)
declare @i real
set @i=1234567890123456789
select datalength(@i) '佔用位元組',@i 'i'
go



--real和float最大可接受的有效位數38位
declare @i float
declare @j real
set @i=12345678901234567890123456789012345678
set @j=12345678901234567890123456789012345678
select datalength(@i) '佔用位元組',@i 'i' 
select datalength(@j) '佔用位元組',@j 'j' 
go


--日期時間

--DataTime 時間為 24 小時，精確至毫秒，其值以 .000、.003 或 .007 秒遞增，詳細請參閱 Online Book 中的 DataTime 資料型別
declare @i datetime
set @i='2015-07-03 14:00:00.000'
select @i 'i'
set @i='2015-07-03 14:00:00.001'
select @i 'i'
set @i='2015-07-03 14:00:00.002'
select @i 'i'
set @i='2015-07-03 14:00:00.003'
select @i 'i'
set @i='2015-07-03 14:00:00.004'
select @i 'i'
set @i='2015-07-03 14:00:00.005'
select @i 'i'
go

--SmaillDataTime 時間為 24 小時，四捨五入精確至『分』
declare @i smalldatetime
set @i='2014-11-04 10:15:30'
select @i 'i'
go

--Time 時間為 24 小時制，精確度100奈秒
declare @i time
set @i='10:15:30.1234567'
select @i 'i'
set @i='10:15:30.12345678'
select @i 'i'
go


/*
  datetime2與datetimeoffset皆為24小時制，記錄年、月、日、時、分、秒，精確度達100奈秒，
  唯一不同為datetimeoffset結合時區感知(UTC)
  */
declare @i datetimeoffset(3)
declare @j datetimeoffset(3)
declare @k datetime2
set @i='2014-11-04 10:15:30.565 +8:00'
set @j='2014-11-04 10:15:30.565'
set @k='2014-11-04 10:15:30.565 +8:00'
select @i 'i',@j 'j',@k 'k'
go


/*
--字串型別
*/
--varchar未宣告時佔1Byte
declare @i varchar
set @i='abcdef'
select datalength(@i) '佔用位元組',@i 'i'
go

--varchar使用多少就佔多少Bytes
declare @i varchar(20)
set @i='abcdefgh'
select datalength(@i) '佔用位元組',@i 'i'
go

--超過Varchar宣告長度的字串,會被截斷
declare @i varchar(20)
set @i='abcdefghijklmnopqrstuvwxyz'
select datalength(@i) '佔用位元組',@i 'i'
go

--char不論有沒有用完,都佔這麼多個Bytes
declare @i char(20)
set @i='abcdefg'
select datalength(@i) '佔用位元組',@i 'i 值','['+@i+']'  '實際 i 值'
go


/*
--Unicode字串型別
*/
--nvarchar未宣告時佔1個字元
declare @i nvarchar
set @i='abcdefg'
select datalength(@i) '佔用位元組',@i 'i'
go

--nvarchar使用多少就佔多少個字元
declare @i nvarchar(20)
set @i='abcdefg'
select datalength(@i) '佔用位元組',@i 'i'
go

--nchar不論有沒有用完,都佔這麼多個字元
declare @i nchar(20)
set @i='abcdefg'
select datalength(@i) '佔用位元組',@i 'i 值','['+@i+']' '實際 i 值',replace(@i,' ','@') '空白置換'
go

--超過nvarchar宣告長度的字串,會被截斷
declare @i nvarchar(20)
set @i='abcdefghijklmnopqrstuvwxyz'
select datalength(@i) '佔用位元組',@i 'i'
go


--貨幣型態接受數值加千分位，精確度到小數第4位 
declare @i varchar(15)
set @i='10,000.12345'
select @i 'i',CAST(@i as money) '貨幣型號'
go

--binary型別
declare @i bigint
declare @j varbinary(20)
set @i=123456
set @j=@i
select @i,@j,cast(@j as int),DATALENGTH(@j)
go


--標記型態
USE test0520
CREATE TABLE [TBL_1](
	[COL1] [nvarchar](50) NOT NULL,
	timestamp,
    [COL2] [uniqueidentifier] NOT NULL DEFAULT NEWID()    
) ON [PRIMARY]
CREATE TABLE [TBL_2](
	[COL1] [nvarchar](50) NOT NULL,
	[COL2] rowversion,
    [COL3] [uniqueidentifier] NOT NULL DEFAULT NEWID()    
) ON [PRIMARY]

go


INSERT INTO TBL_1 (COL1) VALUES ('12345')
INSERT INTO TBL_2 (COL1) VALUES ('12345')
go

SELECT * from TBL_1
SELECT * from TBL_2
go 

UPDATE TBL_1 SET COL1='123456789' WHERE COL1='12345'
UPDATE TBL_2 SET COL1='123456789' WHERE COL1='12345'
SELECT * from TBL_1
SELECT * from TBL_2

drop table tbl_1
drop table tbl_2


--sql_variant型態
USE test0520
CREATE TABLE [TBL_3](
	[COL1] [int] IDENTITY(1,1) NOT NULL,
	[COL2] [sql_variant] NOT NULL
) ON [PRIMARY]

INSERT INTO TBL_3 (COL2) VALUES ('資料存檔')
INSERT INTO TBL_3 (COL2) VALUES (100.33)
INSERT INTO TBL_3 (COL2) VALUES ('12/12/2007 13:13:13.000')
INSERT INTO TBL_3 (COL2) VALUES (CAST('12/12/2007 13:13:13.000' AS DATETIME))
SELECT * from TBL_3
SELECT COL2,SQL_VARIANT_PROPERTY(COL2,'BaseType') 基本資料型態,
	   SQL_VARIANT_PROPERTY(COL2,'PRECISION') 精確度
FROM TBL_3