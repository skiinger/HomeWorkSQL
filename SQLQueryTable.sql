use test0520
go

--新增資料表
create table[訂單資料1](
訂單編號 int,
產品編號 nchar(3),
單價 int,
數量 int,)
on [primary]
go

--刪除資料表
drop table 訂單資料1
go

--建立計算欄位
create table 訂單資料1
(訂單編號 int not null primary key,
產品編號 nchar(3) not null,
單價 int,
數量 int,
小計 as 單價*數量)
go

--建立複合主鍵
create table 訂單明細_1
(訂單編號 int,
產品編號 nchar(3),
單價 int,
數量 int,
constraint PK_訂單明細_1_訂單產品 primary key(訂單編號,產品編號))
go

---建立訂單資料表,訂單編號,客戶編號,下單日期(主鍵由單1欄位扮演)
create table 訂單(
訂單編號 int not null,
客戶編號 nchar(3) not null,
下單日期 datetime constraint DF_下單日期 default getdate()
constraint pk_訂單_訂單編號 primary key(訂單編號))
go

--查詢系統日期
select getdate()
go

--新增1筆資料
insert 訂單 values(2, 'C01' ,default)
go

--查詢訂單資料
select * from 訂單
GO

--建客戶資料表(編號（PK）,客戶名稱,統一編號（UIQ）,聯絡電話,地址)
create table 客戶
(編號 int,
名稱 nvarchar(30) not null,
統一編號 nchar(8),
連絡電話 nvarchar(30),
地址 nvarchar(50),
constraint [PK_客戶_編號] primary key (編號),
constraint [UIQ_客戶_統一編號] unique (統一編號))
go

--新增3筆資料 客戶
insert 客戶 values (1,'臺北市職能發展學院','12345678','02-28721940','臺北市士林區士東路301號')
insert 客戶 values (2,'臺北市政府',NULL,NULL,'臺北市市府路')
insert 客戶 values (3,'臺北市勞動局','22222222',NULL,NULL)
go

--查詢table 客戶
select * from 客戶

--建立具CHECK條件約束的客戶資料表
drop table 客戶
go
create table 客戶
(編號 int,
名稱 nvarchar(30) not null,
統一編號 nchar(8),
連絡電話 nvarchar(30),
地址 nvarchar(50),
constraint [PK_客戶_編號] primary key (編號),
constraint [UIQ_客戶_統一編號] unique (統一編號),
constraint [CK_客戶_電話地址] check (連絡電話 is not null or 地址 is not null))
go

---檢核訂單明細的數量只能填入1~100
create table 訂單明細(
訂單編號 int,
產品編號 nchar(3),
單價 int not null,
數量 int not null,
小計 AS 單價*數量
constraint PK_訂單明細_訂單產品 primary key(訂單編號,產品編號),
constraint CK_訂單明細_數量 check(數量 between 1 and 100))
go

--新增1筆資料 訂單明細 (不符合)
insert 訂單明細  (訂單編號,產品編號,單價,數量) values (3,'P01',250,101)
go
--新增1筆資料 訂單明細 
insert 訂單明細  (訂單編號,產品編號,單價,數量) values (3,'P01',250,99)
go

--建立外來鍵參考
drop table 訂單明細
go

create table 訂單明細(
訂單編號 int,
產品編號 nchar(3),
單價 int not null,
數量 int not null, 
小計 AS 單價*數量
constraint PK_訂單明細_訂單產品 primary key(訂單編號,產品編號),
constraint CK_訂單明細_數量 check(數量 between 1 and 100),
constraint FK_訂單明細_訂單_訂單編號 foreign key (訂單編號) references 訂單(訂單編號))
go

select * from 訂單
select * from 訂單明細
go

--新增1筆資料 訂單
insert 訂單明細 values (2,'P01',50,100)
go

--新增1筆資料 訂單
insert 訂單明細 values (2,'P02',100,30)
go

--新增失敗，無法參考訂單編號--->3
insert 訂單明細 values (3,'P02',100,30)
go

--刪除訂單編號1，因主鍵己被參考，故無法刪除
select * from 訂單
go
delete 訂單 where 訂單編號=2
go

--查詢資料表的條件約束(table constraint)
sp_helpconstraint 訂單明細
go

--客戶資料表-調整『名稱』長度
alter table 客戶 alter column 名稱 nvarchar(50)
go

--客戶資料表-增加『聯絡人』欄位
alter table 客戶 add 聯絡人 nvarchar(50)
go
select * from 客戶
go

--刪除客戶的主鍵
sp_helpconstraint 客戶
go
alter table 客戶 drop constraint PK_客戶_編號
go


--指定客戶資料表主鍵 (要先刪除 UIQ_客戶_統一編號)
alter table 客戶 alter column 統一編號 nchar(8) not null
go
alter table 客戶 add constraint PK_客戶_編號 primary key (統一編號)
go

--訂單明細的數量欄位只能輸入1-50 (更新條件時,值不能有Null)
sp_helpconstraint 訂單明細
go
alter table 訂單明細 drop constraint CK_訂單明細_數量
go
alter table 訂單明細 add constraint CK_訂單明細_數量 check (數量 between 1 and 50)
go
