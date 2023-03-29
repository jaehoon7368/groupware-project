package com.sh.groupware.workingManagement.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

@Mapper
public interface WorkingManagementDao {

	//출근버튼 누를시 출근정보 insert
	int insertStartWork(String empId);

	@Select("select * from working_management where no = #{no}")
	WorkingManagement selectStartwork(String no);

	@Select("select count(*) from working_management where emp_id = #{empId} AND TRUNC(reg_date) = TO_DATE(#{time})")
	int checkStartwork(Map<String, Object> param);

	@Select("select * from working_management where emp_id = #{empId} AND TRUNC(reg_date) = TO_DATE(#{time})")
	WorkingManagement checkWorkTime(Map<String, Object> param);

	@Update("update working_management set end_work = TO_TIMESTAMP_TZ(TO_CHAR(SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul', 'YYYY-MM-DD HH24:MI:SS.FF3'), 'YYYY-MM-DD HH24:MI:SS.FF3 TZR TZD'), state = '업무종료' where emp_id = #{empId} AND TRUNC(reg_date) = TO_DATE(#{time})")
	int updateEndWork(Map<String, Object> param);

	//퇴근버튼 누를시 오늘총근무시간 계산
	int updateDayWorkTime(Map<String, Object> param);

	@Select("select * from working_management where reg_date like '%' || #{date} || '%' and emp_id = #{empId}")
	List<WorkingManagement> selectMonthWok(Map<String, Object> param);

	@Select("select * from working_management where emp_id = #{empId} and reg_date between #{start} and to_date(#{end})+1 order by reg_date")
	List<WorkingManagement> selectWeekDatas(Map<String, Object> param);

	@Select("select sum(day_work_time) from working_management where emp_id = #{empId} and reg_date between #{start} and to_date(#{end})+1 order by reg_date")
	int weekTotalTime(Map<String, Object> param);

	@Select("select nvl(sum(day_work_time),0) from working_management where reg_date like '%' || #{monthTime} || '%' and emp_id = #{empId}")
	int totalMonthTime(Map<String, Object> param);

	//주간 기본근무시간 가져오기
	@Select("select nvl(sum(day_work_time),0) from working_management where emp_id = #{empId} and reg_date between #{start} and to_date(#{end})+1 order by reg_date")
	int selectWeekWorkTime(Map<String, Object> startEndMap);

	//주간 연장근무시간 가져오기
	@Select("select nvl(sum(overtime),0) from working_management where emp_id = #{empId} and reg_date between #{start} and to_date(#{end})+1 order by reg_date")
	int selectWeekOverTime(Map<String, Object> startEndMap);

	//월 연장근무시간 가져오기
	@Select("select nvl(sum(overtime),0) from working_management where reg_date like '%' || #{monthTime} || '%' and emp_id = #{empId}")
	int monthOverTime(Map<String, Object> startEndMap);
	
	@Insert("insert into working_management values(seq_working_management_no.nextval, null, null, null, #{regDate}, #{state}, null, #{empId})")
	int insertRegDateState(WorkingManagement working);

}
