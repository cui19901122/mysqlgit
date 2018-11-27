-- oracle���ݿ��ѧ֮��

select   *   from  t_depts;

select  *  from  t_students
-- ����������number,varchar2,char,date
create table  t_stus
(
   tid  number(5)  primary key ,
   tname  varchar2(20) , -- ������
   tpwd char(6),        -- ����  , 4444
   birthday  date, -- ��������
   money  number(6,2) --6:�ܳ��ȣ�2:С����λ��
)

-- ��ѯsql
select  *  from  t_stus


-- oracle�Զ���������������
create  sequence  seq_t_stus
start  with  100
increment  by 1
nocache;  --û�л��棬��������


-- ��������  �ύ��oracle���ݿ⻺��
insert  into  t_stus   values(seq_t_stus.nextval,
'������','1111',to_date('1997-09-12','yyyy-MM-dd'),1000.77);

insert  into  t_stus   values(seq_t_stus.nextval,
'������','222222',to_date('1997-09-12','yyyy-MM-dd'),2000.77);
commit;
-- oracle�ύ�� ��ʽ�ύ
-- ���� oracle�ֶ�����
commit;

select   *  from  t_stus;

-- ��������
update   t_stus  set  tpwd='888888'  where tid=102;
commit;

-- ��������
insert  into  t_stus   values(seq_t_stus.nextval,
'·͢ΰ','4444',to_date('1997-09-12','yyyy-MM-dd'),3000.77);
commit;

-- ɾ������
delete  from   t_stus  

delete  from  t_stus  where tid=103;
commit;

-- ��ѯ�������е�ѧ��������
select  tname  from   t_stus;

select  *  from  t_depts
select  tname  from  t_employee

-- ��ѯ����������Ա��������
select     tname  from   t_employee  
where  tdnum  in (select dnum  from   t_depts  where  dname='������')

-- �����ѯ

-- �ۺϺ��� count(*)  sum()  max()  min()  avg() ��Ҫ�����һ��

-- ���ú���:1.trim()ȥ���ո�  char���͵��ַ��� 2.round(ֵ��λ��)
--      3.nvl(),ȡֵΪ�գ�ȡĬ��ֵ  4.to_char() ת�����ַ���
    
select  *  from  t_employee

-- ����Ա��������
select  count(*)  from  t_employee

-- ��¼  ���� 1234

-- char(),�̶��ַ�������������;
--varchar2() ���������ַ���
select  count(*)   from  t_employee  where tname='����'  and  trim(tpwd)='1234';

--
select  *  from  t_employee

-- �������Ա������ռ�ܹ��ʺͰٷֱ�
select round(tsalary/(select  sum(tsalary)  from t_employee ),3) 
from  t_employee  where tname='����';

-- ��ѯԱ��������ߵ�Ա������
select   tname  from  t_employee   where   tsalary 
in (select  max(tsalary)  from t_employee);

-- �Ƚ������ >,<,<>,
-- ְ���ǹ��˵�Ա������Ϣ
select   *  from  t_employee  where  tjob<>'����';

-- �޸ı�
alter  table  t_employee  add   money  number(6,2);

-- ɾ�������
alter table  t_employee  drop  column  money;

-- ��ѯ����������
select  tsalary+nvl(tmoney,0) from  t_employee  where tname='����';

-- ����������ռ������İٷֱȣ�����������������������������
-- �����Լ�д.

--ģ����ѯ   like  ��ѯ���������Ա��������
--
select  *  from  t_employee
-- ��ѯ���������Ա��������
select count(*)  from  t_employee  where  tname  like '��%'
-- ��ѯ��������������ֵ�Ա��������
select tname  from  t_employee  where  tname  like '��_'

--�����ѯ  order  by 

-- ���ʰ��Ӹߵ���
select  *  from   t_employee  order  by  tsalary  asc
select  *  from   t_employee  order  by  tsalary  desc

--�����ѯ  group by 

-- Ա��ְ�����������
select  tjob,count(*) from   t_employee  group   by   tjob 

-- Ա���������������
select  taddress,count(*) from   t_employee  group   by   taddress 

-- Ա����Ů�ı��� ???


-- �������ŵ�Ա��������
select nvl(tdnum,'û��'),count(*) from 
t_employee  group   by   tdnum -- �������ע������

select nvl(to_char(tdnum),'û���������'),count(*) from 
t_employee  group   by   tdnum 

-- ����  between...and..  and(��),or(��)   in(�ؼ���)

-- 
select   *  from   t_employee

-- ְ�����ܾ�����߹��ʴ���5000��Ա������Ϣ
select   *  from   t_employee where  tjob='�ܾ���'  or  tsalary>5000

------  ��ҳ��ѯ
-- 1����ѯ������ǰ4����¼
select   *  from   t_employee

-- 2.oracle���и�α�У����ص���  rownum,��ʼ���ڵ�һ�У������ܹ��ƶ�
select  rownum,e.*   from    t_employee    e

select  rownum,e.*   from    t_employee    e  where rownum<=4;

--2����ѯ�����ĵ�2������5���ļ�¼
select  rownum,e.*   from    t_employee    e  where
rownum>=2 and rownum<=5;

select  rownum,e.*   from    t_employee    e  where
rownum   between   2  and  5;

-- ��ѯ�����ĵ�2������5���ļ�¼ʵ�ֵķ�ʽΪ:
select  * from 
(select  rownum rm,e.*   from    t_employee    e  where rownum<=5) tmp
where tmp.rm>=2;

-- ��ҳ��ѯ  --1.ÿҳ2�������һҳ��3ҳ����
-- 1.��һҳ:2��  endNum:2��*��1ҳ  startNum:>(��һҳ-1)*2��
-- 2.����ҳ:2��  endNum:2��*��3ҳ  startNum:>(����ҳ-1)*2��

-----------------------------------------------------------------------------
-- ��ҳ��ѯ  --1.ÿҳ3�������һҳ��3ҳ����
-- 1.��һҳ:3��  endNum:3��*��1ҳ  startNum:>(��һҳ-1)*3��
-- 2.����ҳ:3��  endNum:3��*��3ҳ  startNum:>(����ҳ-1)*3��
select  rownum,e.*   from    t_employee    e


-- ��ҳ��ѯ  --1.ÿҳ3��,��2ҳ������
select  *  from (select  rownum  rm,  e.* from   t_employee    e
where rownum<=3*2) temp  where  temp.rm>(2-1)*3

-- �߼���ѯ

--PL-SQL��


--�洢����


--�Զ��庯��


--�α�

--��̬sql

--������

--����

--��ͼ

--��

--����

-- ��ʱ����












