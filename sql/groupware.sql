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

-- remember-me 관련테이블 persistent_logins
create table persistent_logins (
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null, -- username, password, expiry time 등을 hashing한 값
    last_used timestamp not null
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

alter table
    working_management
modify 
    overtime number ;

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

--좋아요
CREATE TABLE board_like (
    like_no varchar2(20) PRIMARY KEY,
    emp_id VARCHAR2(20) NOT NULL,
    board_no VARCHAR2(15) NOT NULL,
    like_yn CHAR(1) DEFAULT 'N' CHECK (like_yn IN ('Y', 'N')),
    reg_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_board_like_emp FOREIGN KEY (emp_id) REFERENCES emp (emp_id) ON DELETE CASCADE,
    CONSTRAINT fk_board_like_board FOREIGN KEY (board_no) REFERENCES board (no) ON DELETE CASCADE
);

-- 게시판 좋아요 트리거
-- 좋아요 테이블 INSERT 트리거
-- 좋아요 테이블 INSERT 트리거
CREATE OR REPLACE TRIGGER trg_board_like_insert
before INSERT ON board_like
FOR EACH ROW
BEGIN
  UPDATE board SET like_count = like_count + 1 WHERE no = :new.board_no;
END;
/

-- 좋아요 테이블 UPDATE 트리거
CREATE OR REPLACE TRIGGER trg_board_like_update
BEFORE UPDATE ON board_like
FOR EACH ROW
BEGIN
  IF :OLD.like_yn = 'Y' AND :NEW.like_yn = 'N' THEN -- 좋아요를 취소한 경우
    UPDATE board SET like_count = like_count - 1 WHERE no = :NEW.board_no;
  ELSIF :OLD.like_yn = 'N' AND :NEW.like_yn = 'Y' THEN -- 좋아요를 누른 경우
    UPDATE board SET like_count = like_count + 1 WHERE no = :NEW.board_no;
  END IF;
  
  :NEW.like_yn := :NEW.like_yn; -- UPDATE문 대신 :NEW 값을 변경
END;
/
--ALTER TRIGGER ADMIN.TRG_BOARD_LIKE COMPILE;
DROP TRIGGER trg_board_like_insert;
drop table board_like;
select*from board;
create sequence seq_board_like_no;

-- 댓글
create table boardComment (
    no varchar2(15) not null,
    content varchar2(1000) not null,
    reg_date date default sysdate,
    comment_level number default 0,
    ref_comment_no varchar2(20) default null,
    board_no varchar2(15) not null,
    emp_id varchar2(20) not null,
    writer varchar2(20) not null,
    constraint pk_boardcomment primary key (no),
    constraint fk_boardcomment_board foreign key (board_no) references board (no) on delete cascade,
    constraint fk_boardcomment_emp foreign key (emp_id) references emp (emp_id) on delete cascade,
    constraint fk_boardcomment_ref foreign key(ref_comment_no) references boardComment (no) on delete cascade
);
select*from board_Like order by like_no desc; 
delete from board_like where like_no = '23';
select*from boardComment;
insert into boardComment values(seq_boardComment_no.nextval, 'asdfasdfasd', sysdate, default, default, 'bo173', '230301', '230301');
select*from board;

select*from addressbook;
-- 주소록
create table addressbook (
    addr_no varchar2(15) not null,
    name varchar2(20) not null,
    job_name varchar2(15),
    phone varchar2(20),
    dept_title varchar2(20),
    company varchar2(20),
    cpTel varchar2(20),
    cpAddress varchar2(20),
    email varchar2(30) not null,
    reg_date date default sysdate,
    memo varchar2(500),
    addrGroup varchar2(50) not null,
    constraint pk_addressbook primary key (addr_no)
);
--drop table addressbook;
-- 그룹원
create table groupMember (
    group_no varchar2(15) not null,
    addr_no varchar2(15) not null,
    constraint pk_groupMember primary key (group_no, addr_no) -- 복합
);
-- 그룹
create table addressGroup (
    no varchar2(15) not null,
    group_name varchar2(20) not null,
    emp_id varchar2(20) not null,
    constraint pk_group primary key (no),
    constraint fk_group_emp foreign key (emp_id) references emp (emp_id) on delete cascade
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
create sequence seq_emp_id_no;


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
select * from working_management order by no;
select * from dayoff;
select * from dayoffform;
delete from working_management where no = '45';
update working_management set end_work = null, state = '연차',overtime = null where no = '49';

select day_off_year from dayoff group by day_off_year order by day_off_year;
    
delete from emp where emp_id = '230304';

select * from attachment;
select 
    nvl(sum(day_work_time),0) day_work_time,
    nvl(sum(overtime),0) overtime
from 
    working_management 
where 
    emp_id = '230304' and reg_date between '23/03/15' and to_date('23/03/28')+1 order by reg_date;

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
select*from board;
select*from emp;
select*from attachment;
select*from boardComment;



select * from working_management where depte_code = 'd1' and reg_date between ? and ?;

select * from working_management w join emp e on w.emp_id = e.emp_id where dept_code = 'd1' order by w.emp_id,reg_date;

update working_management set end_work = null, overtime = null, day_work_time = null,state='업무중' where no = '35';

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

select  
  d.*  
from(
    select 
        d.day_off_year,
        d.start_date,
        d.end_date,
        d.count,
        d.leave_count,
        df.type,
        df.content,
        (select base_day_off from job where job_code = e.job_code) base_day_off
    from 
        dayoff d join dayoffform df
        on d.form_no = df.no
        join emp e
        on d.emp_id = e.emp_id
    where
        d.emp_id = '230304'
    order by 
        d.no desc
)d
where
    rownum = 1;
