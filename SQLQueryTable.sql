use test0520
go

--�s�W��ƪ�
create table[�q����1](
�q��s�� int,
���~�s�� nchar(3),
��� int,
�ƶq int,)
on [primary]
go

--�R����ƪ�
drop table �q����1
go

--�إ߭p�����
create table �q����1
(�q��s�� int not null primary key,
���~�s�� nchar(3) not null,
��� int,
�ƶq int,
�p�p as ���*�ƶq)
go

--�إ߽ƦX�D��
create table �q�����_1
(�q��s�� int,
���~�s�� nchar(3),
��� int,
�ƶq int,
constraint PK_�q�����_1_�q�沣�~ primary key(�q��s��,���~�s��))
go

---�إ߭q���ƪ�,�q��s��,�Ȥ�s��,�U����(�D��ѳ�1����t)
create table �q��(
�q��s�� int not null,
�Ȥ�s�� nchar(3) not null,
�U���� datetime constraint DF_�U���� default getdate()
constraint pk_�q��_�q��s�� primary key(�q��s��))
go

--�d�ߨt�Τ��
select getdate()
go

--�s�W1�����
insert �q�� values(2, 'C01' ,default)
go

--�d�߭q����
select * from �q��
GO

--�ثȤ��ƪ�(�s���]PK�^,�Ȥ�W��,�Τ@�s���]UIQ�^,�p���q��,�a�})
create table �Ȥ�
(�s�� int,
�W�� nvarchar(30) not null,
�Τ@�s�� nchar(8),
�s���q�� nvarchar(30),
�a�} nvarchar(50),
constraint [PK_�Ȥ�_�s��] primary key (�s��),
constraint [UIQ_�Ȥ�_�Τ@�s��] unique (�Τ@�s��))
go

--�s�W3����� �Ȥ�
insert �Ȥ� values (1,'�O�_��¾��o�i�ǰ|','12345678','02-28721940','�O�_���h�L�Ϥh�F��301��')
insert �Ȥ� values (2,'�O�_���F��',NULL,NULL,'�O�_��������')
insert �Ȥ� values (3,'�O�_���Ұʧ�','22222222',NULL,NULL)
go

--�d��table �Ȥ�
select * from �Ȥ�

--�إߨ�CHECK����������Ȥ��ƪ�
drop table �Ȥ�
go
create table �Ȥ�
(�s�� int,
�W�� nvarchar(30) not null,
�Τ@�s�� nchar(8),
�s���q�� nvarchar(30),
�a�} nvarchar(50),
constraint [PK_�Ȥ�_�s��] primary key (�s��),
constraint [UIQ_�Ȥ�_�Τ@�s��] unique (�Τ@�s��),
constraint [CK_�Ȥ�_�q�ܦa�}] check (�s���q�� is not null or �a�} is not null))
go

---�ˮ֭q����Ӫ��ƶq�u���J1~100
create table �q�����(
�q��s�� int,
���~�s�� nchar(3),
��� int not null,
�ƶq int not null,
�p�p AS ���*�ƶq
constraint PK_�q�����_�q�沣�~ primary key(�q��s��,���~�s��),
constraint CK_�q�����_�ƶq check(�ƶq between 1 and 100))
go

--�s�W1����� �q����� (���ŦX)
insert �q�����  (�q��s��,���~�s��,���,�ƶq) values (3,'P01',250,101)
go
--�s�W1����� �q����� 
insert �q�����  (�q��s��,���~�s��,���,�ƶq) values (3,'P01',250,99)
go

--�إߥ~����Ѧ�
drop table �q�����
go

create table �q�����(
�q��s�� int,
���~�s�� nchar(3),
��� int not null,
�ƶq int not null, 
�p�p AS ���*�ƶq
constraint PK_�q�����_�q�沣�~ primary key(�q��s��,���~�s��),
constraint CK_�q�����_�ƶq check(�ƶq between 1 and 100),
constraint FK_�q�����_�q��_�q��s�� foreign key (�q��s��) references �q��(�q��s��))
go

select * from �q��
select * from �q�����
go

--�s�W1����� �q��
insert �q����� values (2,'P01',50,100)
go

--�s�W1����� �q��
insert �q����� values (2,'P02',100,30)
go

--�s�W���ѡA�L�k�Ѧҭq��s��--->3
insert �q����� values (3,'P02',100,30)
go

--�R���q��s��1�A�]�D��v�Q�ѦҡA�G�L�k�R��
select * from �q��
go
delete �q�� where �q��s��=2
go

--�d�߸�ƪ��������(table constraint)
sp_helpconstraint �q�����
go

--�Ȥ��ƪ�-�վ�y�W�١z����
alter table �Ȥ� alter column �W�� nvarchar(50)
go

--�Ȥ��ƪ�-�W�[�y�p���H�z���
alter table �Ȥ� add �p���H nvarchar(50)
go
select * from �Ȥ�
go

--�R���Ȥ᪺�D��
sp_helpconstraint �Ȥ�
go
alter table �Ȥ� drop constraint PK_�Ȥ�_�s��
go


--���w�Ȥ��ƪ�D�� (�n���R�� UIQ_�Ȥ�_�Τ@�s��)
alter table �Ȥ� alter column �Τ@�s�� nchar(8) not null
go
alter table �Ȥ� add constraint PK_�Ȥ�_�s�� primary key (�Τ@�s��)
go

--�q����Ӫ��ƶq���u���J1-50 (��s�����,�Ȥ��঳Null)
sp_helpconstraint �q�����
go
alter table �q����� drop constraint CK_�q�����_�ƶq
go
alter table �q����� add constraint CK_�q�����_�ƶq check (�ƶq between 1 and 50)
go
