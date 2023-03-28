package com.sh.groupware.sign.model.service;

import java.util.List;

import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.TripForm;

public interface SignService {

	int insertSign(DayOffForm dayOffForm, SignEntity sign);
	
	int insertSign(ResignationForm resignation, SignEntity sign);

	int insertDayOffForm(DayOffForm dayOffForm);
	
	int insertResignationForm(ResignationForm resignation);

	List<Sign> findByMyCreateSignList(String empId);

	int insertSignStatus(SignEntity sign);

	Sign findByNoSign(String no);

	DayOffForm findBySignNoDayOffForm(String no);

	TripForm findBySignNoTripForm(String no);

	ProductForm findBySignNoProductForm(String no);

	ResignationForm findBySignNoResignationForm(String no);

	List<Sign> findByMySignList(String empId);

} // interface end
