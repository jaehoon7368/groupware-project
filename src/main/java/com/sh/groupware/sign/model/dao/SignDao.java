package com.sh.groupware.sign.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;

@Mapper
public interface SignDao {

	int insertSign(SignEntity sign);

	@Insert("insert into dayOffForm values (seq_dayOffForm_no.nextval, #{signNo}, #{type}, #{half}, #{startDate}, #{endDate}, #{count}, #{content})")
	int insertDayOffForm(DayOffForm dayOffForm);
	
	@Insert("insert into signStatus values (seq_signStatus_no.nextval, #{signNo}, #{empId}, #{signOrder}, #{status}, null)")
	int insertSignStatus(SignStatus signStatus);

	List<Sign> findByMyCreateSignList(String empId);

	@Insert("insert into resignationForm values (seq_resignationForm_no.nextval, #{signNo}, #{endDate}, #{reason}")
	int insertResignationForm(ResignationForm resignation);

} // interface end
