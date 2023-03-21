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
    start_work timestamp default systimestamp,
    end_work timestamp,
    overtime timestamp,
    reg_date date default sysdate,
    state varchar2(15),
    day_work_time timestamp,
    emp_id varchar2(20) not null,
    constraint pk_working_management primary key (no),
    constraint fk_working_management_emp foreign key (emp_id) references emp (emp_id) on delete cascade
);


-- 게시판
create table board (
    no varchar2(15) not null,
    category varchar2(15) not null,
    title varchar2(100) not null,
    content varchar2(4000) not null,
    read_count number default 0,
    like_count number default 0,
    created_date date default sysdate,
    updated_date date,
    emp_id varchar2(20) not null,
    constraint pk_board primary key (no),
    constraint fk_board_emp foreign key (emp_id) references emp (emp_id) on delete cascade
);
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