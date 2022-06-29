/*
請建立test0520資料庫，並將資料檔放在D:\DB
初始值為20MB，不限制最大值，自動成長20MB
另建1群組，群組中有一個資料檔放在D:\DB
初始值為20MB，不限制最大值，自動成長20MB
另記錄檔LOG，初始值為15MB，最大值1G
自動成長為30%
*/

create database test0520
on(name =text0520,
		filename = 'C:\SQL\DB\test0520_1.mdf',
		size = 20mb,
		maxsize = unlimited,
		filegrowth = 20mb),
		FILEGROUP G1
		(name = G1,
		filename = 'C:\SQL\DB\G1.ndf',
		size = 20mb,
		maxsize = unlimited,
		filegrowth = 20mb)
log on (name = test0520_log,
		filename = 'C:\SQL\LOG\test0520_log.ldf'
		size = 15mb ,
		maxsize = 1gb ,
		filegrowth = 30%)
go
--刪除資料庫 
DROP database test0520
go

--卸離資料庫
sp_detach_db test0520
go

--附加資料庫(原位置附加)
sp_attach_db test0520 , 'C:\SQL\DB\test0520_1.mdf'
go

--附加資料庫(不同位置附加)
sp_attach_db test0520 , 'C:\SQL\MoveDB\test0520_1.mdf',
						'C:\SQL\MoveDB\G1.ndf',
						 'C:\SQL\MoveDB\test0520_log.ldf'


--附加資料庫(不同位置附加 create database ...for attach)
create database test0520 on
(filename = 'C:\SQL\MoveDB\test0520_1.mdf'),
(filename = 'C:\SQL\MoveDB\G1.ndf'),
(filename = 'C:\SQL\MoveDB\test0520_log.ldf')
for attach 
go

--變更資料檔初始值
alter database test0520 MODIFY FILE (NAME = 'text0520' ,size=60MB)
go

/*在primary群組中增加一個資料檔
  名稱自訂，初始30MB，最大值2GB，自動成長30%*/
  alter database test0520 add FILE 
  (NAME = text0525,
  filename = 'C:\SQL\DB\test0520_2.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
	to filegroup [primary]

/*在G1群組中稱增加一個資料檔
  名稱自定，初始30MB，最大值2GB，自動成長30% */
alter database test0520 add FILE
(name = textG1,
filename = 'C:\SQL\DB\testG1.ndf',
size=30mb,
maxsize=2gb,
filegrowth=30%
)
to filegroup G1

--查詢資料庫
sp_helpdb test0520

--查詢群組
use test0520
sp_helpfilegroup

--刪除剛剛創建的2個資料檔
alter database test0520 REMOVE FILE  textG1
go
alter database test0520 REMOVE FILE  text0525
go

--新增G2群組
alter database test0520 add FILEGROUP G2

--刪除G2群組
alter database test0520 remove FILEGROUP G2

--  DDL語法練習
/*
建立資料庫TestDB,資料庫要有三個檔案群組(含預設群組),每群組需有二個資料檔,
每個資料檔初始容量30MB,每次成長30%,最大限制2G,
建立兩個記錄檔,初始容量10MB,成長10MB,最大限制2G,
資料檔請存DataBase目錄,記錄檔請存DBLog目錄
*/
--刪除資料庫
DROP database testdb
go
--查詢資料庫
sp_helpdb testdb

--查詢群組
use testdb
go
sp_helpfilegroup
go

--建立資料庫TestDB...
create database testdb
on(
name = test01,
filename = 'c:\SQL\DataBase\textdb_1.mdf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%),
(
name = test02,
filename = 'c:\SQL\DataBase\textdb_2.ndf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%
),
filegroup G1
(
name = G1_1,
filename = 'c:\SQL\DataBase\G1_1.ndf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%
),
(
name = G1_2,
filename = 'c:\SQL\DataBase\G1_2.ndf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%
),
filegroup G2
(
name = G2_1,
filename = 'c:\SQL\DataBase\G2_1.ndf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%
),
(
name = G2_2,
filename = 'c:\SQL\DataBase\G2_2.ndf',
size = 30mb,
maxsize = 2gb,
filegrowth = 30%
)
log on
(
name = testdb1_log,
filename = 'c:\SQL\DBLog\testdb1_log.ldf',
size = 10mb,
maxsize = 2gb,
filegrowth = 10mb),
(
name = testdb2_log,
filename = 'c:\SQL\DBLog\testdb2_log.ldf',
size = 10mb,
maxsize = 2gb,
filegrowth = 10mb)
go

--卸離資料庫
use master
go
sp_detach_db testdb
go

--附加資料庫
sp_attach_db testdb , 'C:\SQL\DataBase\textdb_1.mdf'
go
--在Primary群組裡新增一個資料檔案 DB3.NDF
alter database testdb add file
(name=DB3,
filename='C:\SQL\DataBase\DB3.ndf'
)
to filegroup [primary]
go

--刪除資料檔案 DB3.NDF
alter database testdb remove file DB3
go

--請新增一個檔案群組G3
alter database testdb add filegroup G3
go

--新增一個資料檔案G3_DB1
alter database testdb add file
(
name=G3_DB1,
filename='C:\SQL\DataBase\G3_DB1.ndf',
size=30mb,
maxsize=2gb,
filegrowth=30%)
to filegroup G3
GO

--將檔案群組G3修改為Default群組
alter database testdb modify filegroup G3 default;
go

--將Primary群組裡的資料檔案的不限制最大值
alter database testdb modify file
(name='test01', maxsize='unlimited')
go
alter database testdb modify file
(name='test02', maxsize='unlimited')
go

--新增一個記錄檔DB_Log_3,檔案大小500MB
alter database testdb add log file
(name=DB_Log_3,
filename = 'c:\SQL\DBLog\DB_Log_3.ldf',
size = 500mb)
go