--������ƪ�
create database NorthwindC
ON (FileName='C:\SQL\NorthwindC.mdf')
FOR ATTACH
go

use NorthwindC
go


--�p��/�d�� �Ȥ��ƪ� 
select COUNT(*) from �Ȥ�
select * from �Ȥ�
go

--�d�߭��u��ƪ�_����W��
select * from NorthwindC.dbo.���u

--�d�߭��u��ƪ�_�����W��
use NorthwindC
go 
select * from ���u
go 
select ���u�s��,�m�W,¾�� From ���u
go

--�p������
select [���]*[�ƶq] as [����] from [�q�f����]
go
select �m�W+' ' +¾�� as [���q����] from [���u]
go
select LEFT(�m�W,1)+¾��+' '+RIGHT(�m�W,len(�m�W)-1) as [���q����] from ���u
go

--�������Ƹ�ƦC(�O�d�@��)
select distinct ¾�� from ���u
go

--�զX���P���������(���~)
SELECT 14+�m�W [�L��]
FROM DBO.���u
GO

--�զX���P���������(���T)
SELECT CONVERT(nvarchar,14)+�m�W �L��
FROM DBO.���u
GO
SELECT '14'+�m�W [�L��]
FROM DBO.���u
GO

--where �l�y�d��
select * from dbo.���u where ¾��= '�~��'
go
select ���u�s��,�m�W,¾�� from dbo.���u
where year(���Τ��)<=1993
go
--�ϥ��޿�B��l not > and > or
select *
FROM dbo.���u WHERE ¾��= '�~�ȥD��'  AND  �٩I= '�p�j' 
go

--�޿�B��l �s���h�ӱ���P
select * FROM dbo.���~��� 
WHERE  �w�s�q<=�w���s�q  and  (���O�s��=1 or ���O�s��=3) 
go

--IN����r
select * FROM dbo.������ 
WHERE ��F��='�x�_' OR ��F��='�s��' OR ��F��='����'
go
select * FROM dbo.������ 
WHERE ��F�� IN ('�x�_','�s��','����') 
GO

--null��
select * FROM dbo.���u
WHERE �ۤ� is not null
go
select ���u�s��,�m�W,isnull(�ۤ�,'��ú��') as �ۤ� from ���u
go

--�d�߲��~���O��_����W��
select * from NorthwindC.dbo.���~���
go

----�д���1,3,5���O����b10~20����������P�⪺���~ HomeMade
select * FROM dbo.���~���
WHERE (���O�s��='1' OR ���O�s��='3' OR ���O�s��='5') 
AND ���A�P��=0 AND (���>=10 AND ���<=20) 
go
select * FROM dbo.���~���
WHERE  ��� between 10 And 20 AND ���O�s�� in (1,3,5) AND ���A�P��=0
go

--1.�Ч�X�Ȧ�Ȥ�
select * from dbo.�Ȥ�
go
select * FROM dbo.�Ȥ�
WHERE  ���q�W�� LIKE'%�Ȧ�%'
go

--2.�d�ߦb�������W��������
select * from .dbo.������
go
select * FROM dbo.������
WHERE  �a�} LIKE'%������%'
go

--3.�d�߫Ȥ�W�ٲ�1�Ӧr�O�j�Τs�ΪF�����
select * from dbo.�Ȥ�
go
select *FROM dbo.�Ȥ�
WHERE  ���q�W�� LIKE '[�j�s�F]%'
go

--4.��X�Ȥ�s���̫�H AS �� AR �� OS �� OR ���������
select *FROM dbo.�Ȥ�
WHERE  �Ȥ�s�� LIKE'%[AO][SR]'
go

--5.��X�Ȥ�s���ĤG�Ӧr��NAO�γ̫�@�Ӧr��GHIJK���Ȥ���
select * FROM dbo.�Ȥ�
WHERE  �Ȥ�s�� LIKE '_[NAO]%[G-K]'
go

--�E�X���
select SUM(�ƶq)'�q���`��',COUNT(�q�渹�X)'�q�浧��',
AVG(�ƶq)'�����ƶq',MIN(�ƶq)'�浧�q�ʳ̤p��',MAX(�ƶq)'�浧�q�ʳ̤j��'
FROM dbo.[�q�f����]
WHERE ���~�s�� = 51
go

--Group By �l�y
select ¾��,count(*) �H��
FROM dbo.���u
Group by ¾��
go

--�Эp����u¾�٦��h�ֺ�
SELECT COUNT(DISTINCT ¾��) ¾���`�� FROM dbo.���u
go

--�вέp�ʧO�ƶq
select �٩I,count(*)
FROM dbo.���u
Group by �٩I
go
SELECT COUNT(DISTINCT �٩I) �ʧO�ƶq FROM dbo.���u
go

--�Эp��10590�q�檺�`��(���*�ƶq*(1-�馩))
select �q�渹�X,sum(���*�ƶq*(1-�馩))'�q���`��'
FROM dbo.[�q�f����]
WHERE �q�渹�X = 10590
group by �q�渹�X
go

--�Эp��10590�P10591�q�檺�`��
select �q�渹�X,sum(���*�ƶq*(1-�馩))'�q���`��'
FROM dbo.[�q�f����]
WHERE �q�渹�X in(10590,10591)
group by �q�渹�X
go

--�Эp��10590��10670�q�檺�`��(���*�ƶq*(1-�馩))�C��100
select �q�渹�X,sum(���*�ƶq*(1-�馩))'�q���`��'
FROM dbo.[�q�f����]
group by �q�渹�X
Having �q�渹�X between 10590 and 10670 and sum(���*�ƶq*(1-�馩))<100
go

--WITH ROLLUP�B��l 
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  ���~�s��,���
WITH ROLLUP

--WITH CUBE�B��l 
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  ���~�s��,���
WITH CUBE 

--GROUPING SETS�l�y
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  Grouping sets((���~�s��,���),���~�s��)

--GROUPING SETS�l�y �̫�[�`
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  Grouping sets((���~�s��,���),���~�s��,())

--�ƧǸ��ORDER BY ���W�]ASC�^����]DESC�^ 
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  ���  DESC
go
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  [���~���] ASC 
go
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  3
go

--�ʶR���Ƴ̦h��3�����~
SELECT TOP 3 WITH ties ���~�s��,count(���~�s��) �ʶR����
FROM �q�f����
GROUP BY ���~�s��
ORDER BY �ʶR���� DESC

--���� (offset row ��Ʀ첾)
select * from �q�f�D��
order by �q�渹�X OFFSET 5 ROW

--�Ĥ@���}�l(OFFSET ROW)�A�C��10��(FETCH NEXT ROW ONLY)
select * from �q�f�D��
order by �q�渹�X OFFSET 0 ROW FETCH NEXT 10 ROW ONLY

--�ЦC�X�q��10590�M10621���ʶR�����~
select * from dbo.���~���
select * from dbo.�q�f����
go
select �q�渹�X,���~
FROM �q�f���� JOIN ���~���
ON �q�f����.���~�s�� = ���~���.���~�s��
WHERE �q�渹�X in(10590,10621)
go

--�ЦC�X�q��10590��10621���Ȥ�W�١B�p���H�έt�d���q��H��
select * from dbo.�q�f�D��
select * from dbo.���u
select * from dbo.�Ȥ�
go
select C.�s���H[�Ȥ�W��],A.�q�渹�X,A.���f�H [�p���H],B.�m�W[�t�d�q��H��]
FROM �q�f�D�� A JOIN ���u B
ON A.���u�s�� = B.���u�s��
JOIN �Ȥ� C ON A.�Ȥ�s�� = C.�Ȥ�s��
WHERE A.�q�渹�X between 10590 and 10621
order by a.�q�渹�X
go

--�Ч�X�S���q�檺�Ȥ�
--(�Q��right join�s�@�X�s����ƪ�A�P�_�Ȥ�s���P�q��s�����X�{��null��)
select B.�s���H[�S���q�檺�Ȥ�]
FROM �q�f�D�� A right JOIN �Ȥ� B
ON A.�Ȥ�s�� = B.�Ȥ�s��
where A.�q�渹�X is null
go

--�Ч�X�S���q�檺�Ȥ�(�l�d�� ���M��)
select * from �Ȥ� where �Ȥ�s�� not in (select �Ȥ�s�� from �q�f�D��)

--�Ч�X�S���q�檺�Ȥ�(�l�d�� ���ղM��)
select * from �Ȥ� where not EXISTS (select �Ȥ�s�� from �q�f�D�� where �Ȥ�.�Ȥ�s��=�q�f�D��.�Ȥ�s��)

--SELF JOIN (�ۤvJOIN�ۤv)
SELECT 
E1.���u�s��  [���u�s��], 
E1.�m�W  [���u�m�W], 
E2.���u�s��   [�D�޽s��], 
E2.�m�W   [�D�ީm�W] 
FROM   dbo.���u  E1   LEFT  JOIN  dbo.���u   E2 
ON  E1.�D��=E2.���u�s�� 

--UNION �d��(�۰ʹL�o)
SELECT ����, ��F�� 
FROM dbo.���u 
UNION 
SELECT ����, ��F�� 
FROM dbo.�Ȥ�

--UNION �d��(ALL)
SELECT ����, ��F�� 
FROM dbo.���u 
UNION ALL
SELECT ����, ��F�� 
FROM dbo.�Ȥ�

--UNION �p��ƦC
SELECT ����, count(*) �ƶq
FROM dbo.���u 
group by ����
UNION
SELECT ����, count(*)
FROM dbo.�Ȥ�
group by ����
order by 2

--INTERSECT�涰�d�� (�ۦP���)
SELECT   ����, ��F��+ '��' ��F��
FROM     dbo.���u 
INTERSECT 
SELECT   ����, ��F�� 
FROM     dbo.�Ȥ� 

--EXCEPT�t���d�� (���P���)
SELECT   ����, ��F��+ '��' ��F��
FROM     dbo.���u 
EXCEPT
SELECT   ����, ��F�� 
FROM     dbo.�Ȥ� 

--�إ�view��ƪ�
create view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,C.�Ȥ�s��,C.���q�W��,C.�s���H
from �q�f�D�� A join �Ȥ� C ON  A.�Ȥ�s��=C.�Ȥ�s��

--�ק�view��ƪ�
alter view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,C.�Ȥ�s��,C.���q�W��,C.�s���H,C.�q��, a.���u�s��
from �q�f�D�� A join �Ȥ� C ON  A.�Ȥ�s��=C.�Ȥ�s��
go
select * from �q��Ȥ� where �q�渹�X=10260
go
select oc.�q�渹�X, E.�m�W from �q��Ȥ� OC join ���u E on oc.���u�s��=E.���u�s�� where �q�渹�X=10260

--Subquery�l�d��  [select(select...)���浲�G �Afrom(select...)��ƨӷ��Awhere(select...)��ƹL�o]

SELECT  �q�渹�X,(SELECT SUM(�ƶq)  
FROM dbo.�q�f����      
WHERE  dbo.�q�f�D��.�q�渹�X=�q�渹�X ) �`�ƶq
FROM  dbo.�q�f�D��
go
SELECT  O.�q�渹�X,D.�ƶq 
FROM  dbo.�q�f�D�� O 
JOIN (SELECT �q�渹�X,SUM(�ƶq) �ƶq   
FROM dbo.�q�f����  
GROUP BY �q�渹�X ) D  
ON  O.�q�渹�X=D.�q�渹�X 
go

--�W�ߤl�d�߻P���p�l�d�� 
SELECT * FROM dbo.�Ȥ�
WHERE ����  IN (SELECT DISTINCT ����  FROM dbo.���u) 

--���p(Corelated)�l�d��   ���L�k��W�s�b���l�d�� 
SELECT  * FROM  dbo.�q�f�D�� 
WHERE  (SELECT SUM(�ƶq) FROM dbo.�q�f���� WHERE  dbo.�q�f�D��.�q�渹�X=�q�渹�X)>100 