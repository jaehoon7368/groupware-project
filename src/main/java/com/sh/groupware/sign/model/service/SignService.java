package com.sh.groupware.sign.model.service;

import java.util.List;

import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.TripForm;

public interface SignService {

	int insertSignDayOffForm(DayOffForm dayOffForm, SignEntity sign);
	
	int insertSignResignationForm(ResignationForm resignation, SignEntity sign);

	int insertSignTripForm(TripForm tripForm, SignEntity sign);
	
	int insertSignProductForm(ProductForm productForm, SignEntity sign);

	int insertDayOffForm(DayOffForm dayOffForm);
	
	int insertResignationForm(ResignationForm resignation);
	
	int insertTripForm(TripForm tripForm);
	
	int insertProductForm(ProductForm productForm);

	List<Sign> findByMyCreateSignList(String empId);

	int insertSignStatus(SignEntity sign);

	Sign findByNoSign(String no);

	DayOffForm findBySignNoDayOffForm(String no);

	TripForm findBySignNoTripForm(String no);

	ProductForm findBySignNoProductForm(String no);

	ResignationForm findBySignNoResignationForm(String no);

	List<Sign> findByMySignList(String empId);

	int signStatusUpdate(SignStatus signStatus);
	
	int updateMySignStatus(SignStatus signStatus);
	
	int updateNextSignStatus(String no);
	
	int updateSignComplete(String no);
	
	double findByEmpIdTotalCount(String empId);

} // interface end
