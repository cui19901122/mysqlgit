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

-- oracle�ύ�� ��ʽ�ύ
-- ���� oracle�ֶ�����
commit;




