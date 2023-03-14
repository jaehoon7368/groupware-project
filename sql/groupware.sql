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

insert into dept values('d1','인사총무팀');
insert into job values('j1','사장',30);
insert into emp values ('230301','1234','김사장','880101-1081234','서울시 강남구 봉은사대로18-1','230301@gmail.com','010-1234-1234',default,null,default,'j1','d1');

update emp set password = '$2a$10$lIwJyW5vKDbDMmNroJmoLORpC1Bu2l2RlL1lqW9TOF38hzcIoDRTG' where name = '김사장';