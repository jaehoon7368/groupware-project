create table emp ( 
    emp_id varchar2(20) not null,
    password varchar2(300) not null,
    name varchar2(20) not null,
    ssn varchar2(20) not null,
    address varchar2(400) not null,
    email varchar2(50) not null,
    phone varchar2(20) not null,
    hire_date date default sysdate,
    quit_date date,
    quit_yn char default 'N',
    job_code varchar2(15) not null,
    dept_code varchar2(15) not null,
    constraint pk_emp_id primary key (emp_id),
    constraint ck_emp_quit_yn check (quit_yn in ('Y', 'N')),
    constraint fk_emp_job foreign key (job_code) references job (job_code) on delete cascade,
    constraint fk_emp_dept foreign key (dept_code) references dept (dept_code) on delete cascade
);

-- 직급
create table job (
    job_code varchar2(15) not null,
    job_title varchar2(15) not null,
    base_day_off number,
    constraint pk_job primary key (job_code)
);
-- 부서
create table dept (
    dept_code varchar2(15) not null,
    dept_title varchar2(20) not null,
    constraint pk_dept primary key (dept_code)
);

--근태관리
create table working_management(
    no varchar2(15) not null,
    start_work timestamp default TO_TIMESTAMP_TZ(TO_CHAR(SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul', 'YYYY-MM-DD HH24:MI:SS.FF3'), 'YYYY-MM-DD HH24:MI:SS.FF3 TZR TZD'),
    end_work timestamp,
    overtime timestamp,
    reg_date date default TO_TIMESTAMP_TZ(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'Asia/Seoul',
    state varchar2(15),
    day_work_time number,
    emp_id varchar2(20) not null,
    constraint pk_working_management primary key (no),
    constraint fk_working_management_emp foreign key (emp_id) references emp (emp_id) on delete cascade
);

-- 게시판
create table board (
    no varchar2(15) not null,
    b_type varchar2(15) not null,
    title varchar2(100) not null,
    content varchar2(4000) not null,
    read_count number default 0,
    like_count number default 0,
    created_date date default sysdate,
    updated_date date,
    emp_id varchar2(20) not null,
    writer varchar2(20) not null,
    constraint pk_board primary key (no),
    constraint fk_board_emp foreign key (emp_id) references emp (emp_id) on delete cascade,
    constraint fk_board_writer foreign key (writer) references emp (emp_id) on delete cascade
);

-- 게시판 테이블 컬럼 추가
alter table board add writer varchar2(20) not null;
alter table board add foreign key(writer) references emp (emp_id) on delete cascade;
alter table board rename column type to b_type;

-- 댓글
create table boardComment (
    no varchar2(15) not null,
    content varchar2(1000) not null,
    reg_date date default sysdate,
    comment_level number default 0,
    ref_comment_no number,
    board_no varchar2(15) not null,
    emp_id varchar2(20) not null,
    constraint pk_boardcomment primary key (no),
    constraint fk_boardcomment_board foreign key (board_no) references board (no) on delete cascade,
    constraint fk_boardcomment_emp foreign key (emp_id) references emp (emp_id) on delete cascade
);
-- 첨부파일
create table attachment (
    no varchar2(15) not null,
    original_filename varchar2(200) not null,
    rename_filename varchar2(200) not null,
    reg_date date default sysdate,
    category char not null,
    pk_no varchar2(15) not null,
    constraint pk_attachment primary key (no),
    constraint ck_attachment check (category in ('M', 'B', 'T', 'R', 'P'))
);

create sequence seq_working_management_no;
create sequence seq_board_no;
create sequence seq_attachment_no;
create sequence seq_boardComment_no;


insert into dept values('d1','인사총무팀');
insert into dept values('d2','개발');
insert into dept values('d3','법무');
insert into dept values('d4','마케팅');
insert into dept values('d5','기획');

insert into job values('j1','사장',30);
insert into job values('j2','부사장',25);
insert into job values('j3','부장',20);
insert into job values('j4','차장',19);
insert into job values('j5','과장',18);
insert into job values('j6','대리',17);
insert into job values('j7','주임',16);
insert into job values('j8','사원',15);

create table authority (
    emp_id varchar2(20) not null,
    auth varchar2(30) not null,
    constraint pk_authority primary key (emp_id,auth), -- 복합
    constraint fk_emp_id foreign key (emp_id) references emp (emp_id) on delete cascade
);

select * from authority;
select * from job;
select * from dept;
select * from emp;
select * from attachment;
select * from working_management;



delete from emp where emp_id = '230304';

select 
		    b.*,
		    (select count(*) from attachment where no = b.no and category = 'B') attach_count
from
    board b left join emp e
        on b.emp_id = e.emp_id
order by 
    no desc;

select * from board;
delete from board where no = 'bo020';
Insert into BOARD (NO,CATEGORY,TITLE,CONTENT,READ_COUNT,LIKE_COUNT,CREATED_DATE,UPDATED_DATE,EMP_ID,WRITER) values (SEQ_BOARD_NO.nextval,'A','안녕하세요','안녕하세요 테스트중입니다.',DEFAULT,DEFAULT,DEFAULT,null,'230301','김사장');
Insert into BOARD (NO,CATEGORY,TITLE,CONTENT,READ_COUNT,LIKE_COUNT,CREATED_DATE,UPDATED_DATE,EMP_ID,WRITER) values ('1','A','박부사 테스트중이에요','안녕하세요 테스트중입니다.',DEFAULT,DEFAULT,DEFAULT,null,'230302','박부사');
Insert into BOARD (NO,CATEGORY,TITLE,CONTENT,READ_COUNT,LIKE_COUNT,CREATED_DATE,UPDATED_DATE,EMP_ID,WRITER) values (SEQ_BOARD_NO.nextval,'A','안녕하세요','안녕하세요 테스트중입니다.',DEFAULT,DEFAULT,DEFAULT,null,'230303','유사원');
Insert into BOARD (NO,CATEGORY,TITLE,CONTENT,READ_COUNT,LIKE_COUNT,CREATED_DATE,UPDATED_DATE,EMP_ID,WRITER) values (SEQ_BOARD_NO.nextval,'A','안녕하세요','안녕하세요 테스트중입니다.',DEFAULT,DEFAULT,DEFAULT,null,'230304','한소희');

select
	 b.*,
	( select a.* from attachment a where category = 'B')
from
	 board b 
		 left join attachment a
		      on b.no = a.no
where
	 b.no = '1';
     
select
		    b.*,
		    a.*,
		    a.no attach_no
		from
		    board b 
		    	left join attachment a
		        	on b.no = a.no
		where
		    b.no = '1' and a.category = 'B';
            
SELECT
    b.*, a.*, a.no AS attach_no
FROM 
    board b 
        LEFT JOIN attachment a ON b.no = a.no
WHERE
    b.no = '1' AND a.category = 'B';
            
insert into 
			board (no, b_type, title, content,READ_COUNT,LIKE_COUNT,CREATED_DATE,UPDATED_DATE,EMP_ID,WRITER)
		values (
			seq_board_no.nextval,
			'A',
			'안녕하세요',
			'안녕하세요',
			default,
			default,
			default,
            null,
			'230301',
			'김사장'
		);
commit;

select
		    b.*,
		    a.*,
		    a.no attach_no,
		    e.*
		from
		    board b 
		    	left join attachment a
		        	on b.no = a.no
		         left join emp e
            		on b.emp_id = e.emp_id	
		where
		    b.no = 1 ;
            
SELECT
    b.*,
    a.*,
    a.no  attach_no
FROM 
    board b 
        LEFT JOIN attachment a 
            ON b.no = a.no AND a.category = 'B'
WHERE b.no = '23';


SELECT a.no, a.original_filename, a.rename_filename, a.reg_date
FROM attachment a
JOIN board b ON a.pk_no = b.no
WHERE a.category = 'B'
AND a.pk_no = '23';

select*from attachment;
select*from board;

SELECT 
    b.*, 
    a.*, 
    a.no AS attach_no 
FROM 
    board b 
    LEFT JOIN attachment a ON b.no = a.pk_no AND a.category = 'B' 
WHERE 
    b.no = '29';
    
  
		select 
		    b.*,
		    (select count(*) from attachment where no = b.no and category = 'B') attach_count
		from
		    board b left join emp e
		        on b.emp_id = e.emp_id
		order by 
		    no desc;

select*from board order by created_date desc;
select*from boardcomment;

SELECT
    b.*,
    a.*,
    a.no as attach_no
FROM
    board b LEFT JOIN attachment a ON b.no = a.pk_no AND a.category = 'B'
WHERE
    b.b_type = 'N';
    
    SELECT 
		    b.*, 
		    a.*, 
		    a.no AS attach_no 
		FROM 
		    board b 
		    LEFT JOIN attachment a ON b.no = a.pk_no AND a.category = 'B' 
		WHERE 
		    b.no = '1';
