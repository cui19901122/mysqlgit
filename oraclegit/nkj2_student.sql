-- oracle数据库教学之旅

select   *   from  t_depts;

select  *  from  t_students
-- 创建表，类型number,varchar2,char,date
create table  t_stus
(
   tid  number(5)  primary key ,
   tname  varchar2(20) , -- 不定长
   tpwd char(6),        -- 定长  , 4444
   birthday  date, -- 日期类型
   money  number(6,2) --6:总长度，2:小数点位数
)

-- 查询sql
select  *  from  t_stus


-- oracle自动增长，叫做序列
create  sequence  seq_t_stus
start  with  100
increment  by 1
nocache;  --没有缓存，立即生成


-- 插入数据  提交到oracle数据库缓存
insert  into  t_stus   values(seq_t_stus.nextval,
'王安乐','1111',to_date('1997-09-12','yyyy-MM-dd'),1000.77);

insert  into  t_stus   values(seq_t_stus.nextval,
'王启明','222222',to_date('1997-09-12','yyyy-MM-dd'),2000.77);
commit;
-- oracle提交， 正式提交
-- 事务 oracle手动事务
commit;

select   *  from  t_stus;

-- 更新数据
update   t_stus  set  tpwd='888888'  where tid=102;
commit;

-- 插入数据
insert  into  t_stus   values(seq_t_stus.nextval,
'路廷伟','4444',to_date('1997-09-12','yyyy-MM-dd'),3000.77);
commit;

-- 删除数据
delete  from   t_stus  

delete  from  t_stus  where tid=103;
commit;

-- 查询表中所有的学生的姓名
select  tname  from   t_stus;

select  *  from  t_depts
select  tname  from  t_employee

-- 查询属于生产部员工的姓名
select     tname  from   t_employee  
where  tdnum  in (select dnum  from   t_depts  where  dname='技术部')

-- 单表查询

-- 聚合函数 count(*)  sum()  max()  min()  avg() 需要大家练一下

-- 内置函数:1.trim()去除空格  char类型的字符串 2.round(值，位数)
--      3.nvl(),取值为空，取默认值  4.to_char() 转换成字符串
    
select  *  from  t_employee

-- 现在员工的数量
select  count(*)  from  t_employee

-- 登录  李涛 1234

-- char(),固定字符串，不够补足;
--varchar2() 。不定长字符串
select  count(*)   from  t_employee  where tname='李涛'  and  trim(tpwd)='1234';

--
select  *  from  t_employee

-- 李涛这个员工工资占总工资和百分比
select round(tsalary/(select  sum(tsalary)  from t_employee ),3) 
from  t_employee  where tname='李涛';

-- 查询员工工资最高的员工姓名
select   tname  from  t_employee   where   tsalary 
in (select  max(tsalary)  from t_employee);

-- 比较运算符 >,<,<>,
-- 职务不是工人的员工的信息
select   *  from  t_employee  where  tjob<>'工人';

-- 修改表
alter  table  t_employee  add   money  number(6,2);

-- 删除表的列
alter table  t_employee  drop  column  money;

-- 查询丁凯的收入
select  tsalary+nvl(tmoney,0) from  t_employee  where tname='丁凯';

-- 丁凯的收入占总收入的百分比？？？？？？？？？？？？？？？
-- 你们自己写.

--模糊查询   like  查询所有姓李的员工的数量
--
select  *  from  t_employee
-- 查询所有姓李的员工的数量
select count(*)  from  t_employee  where  tname  like '李%'
-- 查询所有姓李的两个字的员工的数量
select tname  from  t_employee  where  tname  like '李_'

--排序查询  order  by 

-- 工资按从高到低
select  *  from   t_employee  order  by  tsalary  asc
select  *  from   t_employee  order  by  tsalary  desc

--分组查询  group by 

-- 员工职务的数量比例
select  tjob,count(*) from   t_employee  group   by   tjob 

-- 员工籍贯的数量比例
select  taddress,count(*) from   t_employee  group   by   taddress 

-- 员工男女的比例 ???


-- 各个部门的员工的数量
select nvl(tdnum,'没有'),count(*) from 
t_employee  group   by   tdnum -- 这个报错，注意类型

select nvl(to_char(tdnum),'没有这个部门'),count(*) from 
t_employee  group   by   tdnum 

-- 补充  between...and..  and(和),or(或)   in(关键字)

-- 
select   *  from   t_employee

-- 职务是总经理或者工资大于5000的员工的信息
select   *  from   t_employee where  tjob='总经理'  or  tsalary>5000

------  分页查询
-- 1。查询这个表的前4条记录
select   *  from   t_employee

-- 2.oracle中有个伪列，隐藏的列  rownum,它始终在第一行，不不能够移动
select  rownum,e.*   from    t_employee    e

select  rownum,e.*   from    t_employee    e  where rownum<=4;

--2。查询这个表的第2条到第5条的记录
select  rownum,e.*   from    t_employee    e  where
rownum>=2 and rownum<=5;

select  rownum,e.*   from    t_employee    e  where
rownum   between   2  and  5;

-- 查询这个表的第2条到第5条的记录实现的方式为:
select  * from 
(select  rownum rm,e.*   from    t_employee    e  where rownum<=5) tmp
where tmp.rm>=2;

-- 分页查询  --1.每页2条，查第一页，3页数据
-- 1.第一页:2条  endNum:2条*第1页  startNum:>(第一页-1)*2条
-- 2.第三页:2条  endNum:2条*第3页  startNum:>(第三页-1)*2条

-----------------------------------------------------------------------------
-- 分页查询  --1.每页3条，查第一页，3页数据
-- 1.第一页:3条  endNum:3条*第1页  startNum:>(第一页-1)*3条
-- 2.第三页:3条  endNum:3条*第3页  startNum:>(第三页-1)*3条
select  rownum,e.*   from    t_employee    e


-- 分页查询  --1.每页3条,第2页的数据
select  *  from (select  rownum  rm,  e.* from   t_employee    e
where rownum<=3*2) temp  where  temp.rm>(2-1)*3

-- 高级查询

--PL-SQL块


--存储过程


--自定义函数


--游标

--动态sql

--触发器

--索引

--视图

--锁

--事务

-- 定时任务












