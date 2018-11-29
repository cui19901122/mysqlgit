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


-- ����ѯ 
select   *  from  t_depts

select  * from t_employee

--�ѿ�����
select   *  from  t_depts,t_employee

-- ��ͨ���Ӳ�ѯ

-- ��ѯÿ��Ա��������������Ϣ�͸�����Ϣ

-- Ա���Ĳ��ű�ŵ��ڲ��ű��
-- ��ͨ��ѯ
select   *  from  t_depts d,t_employee  e
where  e.tdnum=d.dnum;

-- �����Ӳ�ѯ A�� inner   join   B�� ..on ��ʲô����������
select  * from  t_employee  e  inner   join  t_depts d 
on e.tdnum=d.dnum

-- �����Ӳ�ѯ  �����Ϊ��׼��
-- ��ѯÿ��Ա�����������ŵ���Ϣ(����û�в��ŵ�Ա��)
select  * from  t_employee  e  left   join  t_depts d 
on e.tdnum=d.dnum

--�����Ӳ�ѯ ���ұ�Ϊ��׼��
-- ��ѯÿ�����ŵ�����Ա��(��������û��Ա���Ĳ�����Ϣ)
select  * from  t_employee  e  right   join  t_depts d 
on e.tdnum=d.dnum

-- ȫ���ӣ����еĶ���ѯ���������ж�Ӧ���ϵġ�

select  * from  t_employee  e  full   join  t_depts d 
on e.tdnum=d.dnum


-- ��ѯ���εĲ��ŵ�����

--1.�����Ӳ�ѯ
select d.dname   from   t_employee  e   inner  join  t_depts  d 
on  e.tdnum=d.dnum where e.tname='����';
--2.�Ӳ�ѯ  Ч�ʱȽ���������ʹ�����Ӳ�ѯ
select  d.dname from  t_depts d  where 
d.dnum=(select  e.tdnum  from   t_employee  e where e.tname='����')

--3.��ѯ��������Ա������Ϣ
select  e.tname,d.dname
from  t_depts  d  inner  join  t_employee e  on  
d.dnum=e.tdnum   where d.dname='������'

select  e.tname  from  t_employee  e  
where e.tdnum=(select d.dnum  from  t_depts  d  where d.dname='������')

select  e.tname, temp.dname from  
(select d.dnum ,d.dname from  t_depts  d  where d.dname='������') temp 
inner  join   t_employee  e   on temp.dnum=e.tdnum 


-- ��ѯÿ�����ŵ�Ա��������
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname 
-- ��ѯÿ�����ŵ�Ա��������������������1�˵�
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname   having  count(tname)>1


-- ��ѯÿ�����ŵ�Ա������������������
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname   order  by count(tname)  desc


-- ��ѯÿ�����ŵļ����Ա������(˫�����ѯ)
select   count(tname) ,d.dname ,nvl(e.taddress,'û��') from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname ,e.taddress

-- �߼���ѯ

--PL-SQL��

-- ��,�ǰ�һ��Ҳ���Ƕ���sql��һ��ִ��


--��Ľṹ
declare
 -- ����
begin
 -- ����sql���
end;
-----------------------------------------------------------------------------------------------
-- ����û��Ƿ����еģ�������еģ����ʼ�100�������Ů�ģ����ʼ�50


-- ����һ�������ж��������ż��������
accept  num   prompt '������һ����';
declare
-- ����һ������  :=��ʾ���Ǹ�������ֵ
numa number:=&num;
begin
  --�ж������
  if   mod(numa,2)=0    then
    -- ���  ||��ʾ��������   
    dbms_output.put_line('�����'||numa||'��ż��');
  else
     dbms_output.put_line('�����'||numa||'������');
  end  if;
end;
------------------------------------------------------------------------------------
select  * from  t_students

-- ���һ��ѧ����������������е�,����500�������Ů�Ľ���1000Ԫ
-- ��������ѧ�����������Ϣ
accept  uname  prompt '������һ��ѧ��������:';
declare
  -- ����ѧ���ı���  := �Ǹ�һ��������ֵ
  v_name  varchar2(50):='&uname';
  v_sex  t_students.stusex%type;
  v_salary  t_students.money%type;
  v_str  varchar2(200);
begin
   --��ѯ���ѧ�����Ա�  ��sql����и�ֵ��into,����ֻ�ܸ�һ��ֵ�� ���ܸ����ֵ
   select  stusex  into v_sex  from  t_students  where  stuname=v_name;
    dbms_output.put_line(v_name||',ѧ�����Ա�Ϊ:'||v_sex);
    
    --���Ա�����ж�
    -- �Ƚ�ֵ��һ�� =
    if  v_sex='��' then
        v_salary:=500;
    else
        v_salary:=1000;
    end  if;
    
    -- ִ�����ݿ�ѧ����ĵĸ���
    update  t_students  set  money=money+v_salary where 
    stuname=v_name;
    commit;
    
    --�������˵����µ���Ϣ
    select stuname||'����Ϊ:'||money  into  v_str  from  t_students where 
    stuname=v_name;
    
    --���
    dbms_output.put_line(v_str);
-- �쳣  
exception

when others then

  v_str:='û�������';
 dbms_output.put_line(v_str);
end;


--�洢����
create  or  replace   procedure  p_query
(

)
as

begin 


end;

--�Զ��庯��


--�α�

--��̬sql

--������

--����

--��ͼ

--��

--����

-- ��ʱ����












