/*
�Ыإ�test0520��Ʈw�A�ñN����ɩ�bD:\DB
��l�Ȭ�20MB�A������̤j�ȡA�۰ʦ���20MB
�t��1�s�աA�s�դ����@�Ӹ���ɩ�bD:\DB
��l�Ȭ�20MB�A������̤j�ȡA�۰ʦ���20MB
�t�O����LOG�A��l�Ȭ�15MB�A�̤j��1G
�۰ʦ�����30%
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
--�R����Ʈw 
DROP database test0520
go

--������Ʈw
sp_detach_db test0520
go

--���[��Ʈw(���m���[)
sp_attach_db test0520 , 'C:\SQL\DB\test0520_1.mdf'
go

--���[��Ʈw(���P��m���[)
sp_attach_db test0520 , 'C:\SQL\MoveDB\test0520_1.mdf',
						'C:\SQL\MoveDB\G1.ndf',
						 'C:\SQL\MoveDB\test0520_log.ldf'


--���[��Ʈw(���P��m���[ create database ...for attach)
create database test0520 on
(filename = 'C:\SQL\MoveDB\test0520_1.mdf'),
(filename = 'C:\SQL\MoveDB\G1.ndf'),
(filename = 'C:\SQL\MoveDB\test0520_log.ldf')
for attach 
go

--�ܧ����ɪ�l��
alter database test0520 MODIFY FILE (NAME = 'text0520' ,size=60MB)
go

/*�bprimary�s�դ��W�[�@�Ӹ����
  �W�٦ۭq�A��l30MB�A�̤j��2GB�A�۰ʦ���30%*/
  alter database test0520 add FILE 
  (NAME = text0525,
  filename = 'C:\SQL\DB\test0520_2.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
	to filegroup [primary]

/*�bG1�s�դ��ټW�[�@�Ӹ����
  �W�٦۩w�A��l30MB�A�̤j��2GB�A�۰ʦ���30% */
alter database test0520 add FILE
(name = textG1,
filename = 'C:\SQL\DB\testG1.ndf',
size=30mb,
maxsize=2gb,
filegrowth=30%
)
to filegroup G1

--�d�߸�Ʈw
sp_helpdb test0520

--�d�߸s��
use test0520
sp_helpfilegroup

--�R�����Ыت�2�Ӹ����
alter database test0520 REMOVE FILE  textG1
go
alter database test0520 REMOVE FILE  text0525
go

--�s�WG2�s��
alter database test0520 add FILEGROUP G2

--�R��G2�s��
alter database test0520 remove FILEGROUP G2

--  DDL�y�k�m��
/*
�إ߸�ƮwTestDB,��Ʈw�n���T���ɮ׸s��(�t�w�]�s��),�C�s�ջݦ��G�Ӹ����,
�C�Ӹ���ɪ�l�e�q30MB,�C������30%,�̤j����2G,
�إߨ�ӰO����,��l�e�q10MB,����10MB,�̤j����2G,
����ɽЦsDataBase�ؿ�,�O���ɽЦsDBLog�ؿ�
*/
--�R����Ʈw
DROP database testdb
go
--�d�߸�Ʈw
sp_helpdb testdb

--�d�߸s��
use testdb
go
sp_helpfilegroup
go

--�إ߸�ƮwTestDB...
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

--������Ʈw
use master
go
sp_detach_db testdb
go

--���[��Ʈw
sp_attach_db testdb , 'C:\SQL\DataBase\textdb_1.mdf'
go
--�bPrimary�s�ո̷s�W�@�Ӹ���ɮ� DB3.NDF
alter database testdb add file
(name=DB3,
filename='C:\SQL\DataBase\DB3.ndf'
)
to filegroup [primary]
go

--�R������ɮ� DB3.NDF
alter database testdb remove file DB3
go

--�зs�W�@���ɮ׸s��G3
alter database testdb add filegroup G3
go

--�s�W�@�Ӹ���ɮ�G3_DB1
alter database testdb add file
(
name=G3_DB1,
filename='C:\SQL\DataBase\G3_DB1.ndf',
size=30mb,
maxsize=2gb,
filegrowth=30%)
to filegroup G3
GO

--�N�ɮ׸s��G3�קאּDefault�s��
alter database testdb modify filegroup G3 default;
go

--�NPrimary�s�ո̪�����ɮת�������̤j��
alter database testdb modify file
(name='test01', maxsize='unlimited')
go
alter database testdb modify file
(name='test02', maxsize='unlimited')
go

--�s�W�@�ӰO����DB_Log_3,�ɮפj�p500MB
alter database testdb add log file
(name=DB_Log_3,
filename = 'c:\SQL\DBLog\DB_Log_3.ldf',
size = 500mb)
go