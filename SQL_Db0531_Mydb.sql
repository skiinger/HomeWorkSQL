
create database DB0531
GO
use DB0531
go
--新增條件約束
CREATE TABLE 客戶
(  客戶編號  int identity NOT NULL,
   身份證字號  nchar(10) NOT NULL ,  
   年齡  tinyint ,
   地址  nvarchar(50),
   電話  nchar(12))
go

insert into 客戶 (身份證字號,年齡,地址,電話) values ('a1234565',25,'a123455','02889445')
go 100


select count(*) from 客戶

select * from 客戶

sp_helpconstraint 客戶
--with NO check
alter table 客戶 with nocheck add constraint [CK_客戶電話] check (電話 is not null)
go

--drop constraint
alter table 客戶 drop constraint [CK_客戶電話] 
go

--with check
alter table 客戶 add constraint [CK_客戶電話] check (電話 is not null)
go


--新增條件約束Primary KEY
alter table 客戶 add constraint [PK_客戶編號] PRIMARY KEY (客戶編號)
go


--插入一個編號在識別欄位裡
select * from 客戶

alter table 客戶 add 客戶姓名 nvarchar(50)
delete 客戶 where 客戶編號=1


SET IDENTITY_INSERT 客戶 ON


INSERT INTO 客戶 (客戶編號,身份證字號,地址,電話) values (101,'A123456789','台北市','123456789')

SELECT * FROM 客戶

SET IDENTITY_INSERT 客戶 OFF
go



--參考完整性
use DB0531
go


if exists (select * from sys.tables where name='訂單')
drop table 訂單
go

if exists (select * from sys.tables where name='客戶')
drop table 客戶
go


CREATE TABLE dbo.[客戶](
   客戶編號  int  not null,
   客戶姓名  nvarchar(20) not null,
   身份證字號  nchar(10) not null,   
   地址  nvarchar(50),
   電話  nvarchar(12),     
   CONSTRAINT [PK_客戶編號] PRIMARY KEY (客戶編號)   
)
go

CREATE TABLE dbo.[訂單](
	訂單編號  int identity not null,
    客戶編號  int	,
	下單日期  datetime,	
	單價  int,
	數量  int,
	小計  as 單價*數量,
	CONSTRAINT [FK_客戶編號_客戶] FOREIGN KEY(客戶編號)
	REFERENCES [客戶](客戶編號)
)
go

INSERT [客戶] VALUES (1,'小陳','A123456789','台北市','1112233')
INSERT [客戶] VALUES (2,'小張','A234567890','台北縣','3456221')
INSERT [客戶] VALUES (3,'小李','A122343212','桃園市','5454554')
INSERT [客戶] VALUES (4,'小黃','A125427565','台中市','5221456')

INSERT [訂單] VALUES (1,'2009/03/03 15:00:02',5,100)
INSERT [訂單] VALUES (1,'2009/03/04 15:15:30',6,120)
INSERT [訂單] VALUES (2,'2009/02/03 11:20:02',10,121)
INSERT [訂單] VALUES (2,'2009/03/01 15:50:30',8,50)
INSERT [訂單] VALUES (3,'2009/03/04 16:44:00',60,60)
INSERT [訂單] VALUES (3,'2009/03/04 09:33:00',2,80)
go

select * from 客戶
select * from 訂單

--無法刪除客戶編號『1』的資料
DELETE 客戶 WHERE 客戶編號=1
go

delete from 訂單 where 客戶編號=1
go

--暫時停用外來鍵參考
exec sp_helpconstraint 客戶

alter table 訂單 nocheck constraint [FK_客戶編號_客戶]
--啟用
ALTER TABLE 訂單 CHECK CONSTRAINT [FK_客戶編號_客戶]
go



--變更外來鍵參考處理方式
ALTER TABLE 訂單 DROP CONSTRAINT  [FK_客戶編號_客戶]
go

sp_helpconstraint 訂單
GO

ALTER TABLE 訂單 ADD  CONSTRAINT  [FK_客戶編號_客戶] FOREIGN KEY (客戶編號) REFERENCES [客戶](客戶編號) 
  ON DELETE CASCADE  
  ON UPDATE CASCADE
go

SELECT * FROM 客戶
SELECT * FROM 訂單

UPDATE 客戶 SET 客戶編號=5 WHERE 客戶編號=3


delete 客戶 WHERE 客戶編號=5


SELECT * FROM 客戶
go



--delete AND Truncate
use master
go

if exists(select * from sys.databases where name='mydb')
drop database mydb
go

--主群組的資料檔
CREATE DATABASE MyDB
ON primary(
	NAME=MyDB1,
	FileName='C:\SQL\DB\MyDB1.mdf',	
	SIZE=8MB),

--新建群組的資料檔
FileGroup G1(
	NAME=MyDB_G1_1,
	FileName='C:\SQL\DB\MyDB_G1_1.ndf',
	SIZE=8MB),
	(
	NAME=MyDB_G1_2,
	FileName='C:\SQL\DB\\MyDB_G1_2.ndf',
	SIZE=8MB)
--建立Log檔
Log ON (
	NAME=MyDB_Log,
	FileName='C:\SQL\DB\MyDB_Log.ldf'
	)
GO



use MYDB
go


CREATE TABLE 客戶1
(  客戶編號  int identity NOT NULL,
   身份證字號  nchar(10) NOT NULL ,  
   年齡  tinyint ,
   地址  nvarchar(50),
   電話  nchar(12)) on [primary]
go

CREATE TABLE 客戶2
(  客戶編號  int identity NOT NULL,
   身份證字號  nchar(10) NOT NULL ,  
   年齡  tinyint ,
   地址  nvarchar(50),
   電話  nchar(12)) on G1
go

insert into 客戶1 values ('a1234565',25,'a123455',null)
go 2000
insert into 客戶2 values ('a1234565',25,'a123455',null)
go 2000

select COUNT(*) from 客戶1
select COUNT(*) from 客戶2
select * from 客戶1 
select * from 客戶2

--從分頁清除
Truncate table 客戶1

--一筆一筆刪除
delete from 客戶2
go

use master
go

--備分資料庫
backup database mydb to disk ='C:\SQL\DB\mydb.bak'
go

drop database MyDB
go

--還原資料庫
restore database mydb from disk='C:\SQL\DB\mydb.bak'
go

--當資料檔中還有資料時，無法刪除資料檔
alter database mydb remove file MyDB_G1_2
go

--SHRINKFILE可以將資料移出至同一群組的資料檔中
DBCC SHRINKFILE (MyDB_G1_2, EMPTYFILE);  
GO 

sp_helpdb mydb

--釋放資料檔佔用空間，但可低於原初始值容量
DBCC SHRINKFILE (MYDB1,1)
go

--釋放資料檔佔用空間，但最多不低於原初始值容量
DBCC SHRINKDATABASE (mydb)
go

