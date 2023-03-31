package com.sh.groupware.sign.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.TripForm;

@Mapper
public interface SignDao {

	int insertSign(SignEntity sign);

	@Insert("insert into dayOffForm values (seq_dayOffForm_no.nextval, #{signNo}, #{type}, #{half}, #{startDate}, #{endDate}, #{count}, #{content})")
	int insertDayOffForm(DayOffForm dayOffForm);

	@Insert("insert into resignationForm values (seq_resignationForm_no.nextval, #{signNo}, #{endDate}, #{reason})")
	int insertResignationForm(ResignationForm resignation);

	@Insert("insert into tripForm values (seq_tripForm_no.nextval, #{signNo}, #{startDate}, #{endDate}, #{location}, #{purpose})")
	int insertTripForm(TripForm tripForm);
	
	@Insert("insert into productForm values (seq_productForm_no.nextval, #{signNo}, #{name}, #{amount}, #{price}, #{totalPrice}, #{purpose})")
	int insertProductForm(ProductForm productForm);
	
	@Insert("insert into signStatus values (seq_signStatus_no.nextval, #{signNo}, #{empId}, #{signOrder}, #{status}, null, null)")
	int insertSignStatus(SignStatus signStatus);

	List<Sign> findByMyCreateSignListComlete(String empId);

	List<Sign> findByMyCreateSignListIng(String empId);

	Sign findByNoSign(String no);

	@Select("select * from dayOffForm where sign_no = #{no}")
	DayOffForm findBySignNoDayOffForm(String no);

	@Select("select * from tripForm where sign_no = #{no}")
	TripForm findBySignNoTripForm(String no);

	@Select("select * from productForm where sign_no = #{no}")
	List<ProductForm> findBySignNoProductForm(String no);

	@Select("select * from resignationForm where sign_no = #{no}")
	ResignationForm findBySignNoResignationForm(String no);

	List<Sign> findByMySignList(String empId);

	@Select("select * from signStatus where sign_no = #{signNo}")
	List<SignStatus> findBySignNoAllSignStatus(String signNo);

	int updateMySignStatus(SignStatus signStatus);

	@Update("update signStatus set status = 'W' where no = #{no}")
	int updateNextSignStatus(String no);

	@Update("update sign set complete = 'Y' where no = #{no}")
	int updateSignComplete(String no);

	String findByEmpIdLeaveCount(String empId);

	double findByEmpIdBaseDayOff(String empId);

	@Delete("delete from sign where no = #{no}")
	int deleteOneSign(Object no);

	@Delete("delete from signStatus where sign_no = #{no}")
	int deleteSignStatus(Object no);

	@Delete("delete from ${form} where sign_no = #{no}")
	int deleteSignForm(Map<String, Object> param);
	
	List<Sign> findByEmpIdMySignStatus(Map<String, Object> param);

	@Update("update productForm set name = #{name}, amount = #{amount}, price = #{price}, total_price = #{totalPrice}, purpose = #{purpose} where no = #{no}")
	int updateProductForm(ProductForm product);

	@Update("update resignationForm set end_date = #{endDate}, reason = #{reason} where no = #{no}")
	int updateResignationForm(ResignationForm resignation);

	@Update("update tripForm set start_date = #{startDate}, end_date = #{endDate}, location = #{location}, purpose = #{purpose} where no = #{no}")
	int updateTripForm(TripForm trip);

	@Update("update dayOffForm set type = #{type}, half = #{half}, start_date = #{startDate}, end_date = #{endDate}, count = #{count}, content = #{content} where no = #{no}")
	int updateDayOffForm(DayOffForm dayOff);

	List<Map<String, Object>> findByEmpIdToBeNoDateDayOff(String empId);

	List<Map<String, Object>> findByEmpIdToBeNoDateTrip(String empId);

} // interface end
