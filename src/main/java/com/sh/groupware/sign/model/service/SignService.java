package com.sh.groupware.sign.model.service;

import java.util.List;
import java.util.Map;

import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.TripForm;

public interface SignService {

	String insertSign(SignEntity sign);
	
	int insertSignDayOffForm(DayOffForm dayOffForm, SignEntity sign);
	
	int insertSignResignationForm(ResignationForm resignation, SignEntity sign);

	int insertSignTripForm(TripForm tripForm, SignEntity sign);

	int insertDayOffForm(DayOffForm dayOffForm);
	
	int insertResignationForm(ResignationForm resignation);
	
	int insertTripForm(TripForm tripForm);
	
	int insertProductForm(ProductForm productForm);

	List<Sign> findByMyCreateSignListComlete(String empId);

	List<Sign> findByMyCreateSignListIng(String empId);

	int insertSignStatus(SignEntity sign);

	Sign findByNoSign(String no);

	DayOffForm findBySignNoDayOffForm(String no);

	TripForm findBySignNoTripForm(String no);

	List<ProductForm> findBySignNoProductForm(String no);

	ResignationForm findBySignNoResignationForm(String no);

	List<Sign> findByMySignList(String empId);

//	int signStatusUpdate(SignStatus signStatus);
	
	int updateMySignStatus(SignStatus signStatus);
	
	int updateNextSignStatus(String no);
	
	int updateSignComplete(String no);
	
	double findByEmpIdTotalCount(String empId);

	int deleteOneSign(Map<String, Object> param);
	
	int deleteSignStatus(Object no);
	
	int deleteSignForm(Map<String, Object> param);

	List<Sign> findByEmpIdMySignStatus(Map<String, Object> param);

	int updateProductForm(ProductForm product);

	int updateResignationForm(ResignationForm resignation);

	int updateDayOffForm(DayOffForm dayOff);

	int updateTripForm(TripForm trip);

	List<Map<String, Object>> findByEmpIdToBeNoDateDayOff(String empId);

	List<Map<String, Object>> findByEmpIdToBeNoDateTrip(String empId);

	List<Map<String, Object>> findByEmpIdSignNoToBeNoDateDayOff(Map<String, Object> param);

	List<Map<String, Object>> findByEmpIdSignNoToBeNoDateTrip(Map<String, Object> param);

} // interface end
