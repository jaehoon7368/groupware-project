package com.sh.groupware.sign.model.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.dayOff.model.dao.DayOffDao;
import com.sh.groupware.dayOff.model.dto.DayOff;
import com.sh.groupware.emp.model.dao.EmpDao;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.sign.model.dao.SignDao;
import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ProductForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.SignStatusDetail;
import com.sh.groupware.sign.model.dto.SignType;
import com.sh.groupware.sign.model.dto.Status;
import com.sh.groupware.sign.model.dto.TripForm;
import com.sh.groupware.workingManagement.model.dao.WorkingManagementDao;
import com.sh.groupware.workingManagement.model.dto.WorkingManagement;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class SignServiceImpl implements SignService {

	@Autowired
	private SignDao signDao;
	
	@Autowired
	private EmpDao empDao;
	

	@Override
	public String insertSign(SignEntity sign) {
		int result = signDao.insertSign(sign);
		result = insertSignStatus(sign);
		return sign.getNo();
	} // insertSign() end
	
	
	@Override
	public int insertSignDayOffForm(DayOffForm dayOffForm, SignEntity sign) {
		int result = signDao.insertSign(sign);
		dayOffForm.setSignNo(sign.getNo());
		
		result = insertDayOffForm(dayOffForm);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSignDayOffForm() end

	
	@Override
	public int insertDayOffForm(DayOffForm dayOffForm) {
		return signDao.insertDayOffForm(dayOffForm);
	} // insertDayOffForm() end
	
	
	@Override
	public int updateDayOffForm(DayOffForm dayOff) {
		return signDao.updateDayOffForm(dayOff);
	} // updateDayOffForm() end
	
	
	@Override
	public int insertSignTripForm(TripForm tripForm, SignEntity sign) {
		int result = signDao.insertSign(sign);
		tripForm.setSignNo(sign.getNo());
		
		result = insertTripForm(tripForm);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSignTripForm() end
	
	
	@Override
	public int insertTripForm(TripForm tripForm) {
		return signDao.insertTripForm(tripForm);
	} // insertTripForm() end
	
	
	@Override
	public int updateTripForm(TripForm trip) {
		return signDao.updateTripForm(trip);
	} // updateTripForm() end
	
	
	@Override
	public int insertSignResignationForm(ResignationForm resignation, SignEntity sign) {
		int result = signDao.insertSign(sign);
		resignation.setSignNo(sign.getNo());
		
		result = insertResignationForm(resignation);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSignResignationForm() end
	
	
	@Override
	public int updateResignationForm(ResignationForm resignation) {
		return signDao.updateResignationForm(resignation);
	} // updateResignationForm() end

	
	@Override
	public int insertResignationForm(ResignationForm resignation) {
		return signDao.insertResignationForm(resignation);
	} // insertResignationForm() end
	
	
	@Override
	public int insertProductForm(ProductForm productForm) {
		return signDao.insertProductForm(productForm);
	} // insertProductForm() end
	
	
	@Override
	public int updateProductForm(ProductForm product) {
		return signDao.updateProductForm(product);
	} // updateProductForm() end


	@Override
	public List<Sign> findByMyCreateSignListComlete(String empId) {
		return signDao.findByMyCreateSignListComlete(empId);
	} // findByMyCreateSignListComlete() end

	
	@Override
	public List<Sign> findByMyCreateSignListIng(String empId) {
		return signDao.findByMyCreateSignListIng(empId);
	} // findByMyCreateSignListIng() end
	
	
	@Override
	public Sign findByNoSign(String no) {
		return signDao.findByNoSign(no);
	} // findByNoSign() end
	
	
	@Override
	public DayOffForm findBySignNoDayOffForm(String no) {
		return signDao.findBySignNoDayOffForm(no);
	} // findBySignNoDayOffForm() end
	
	
	@Override
	public TripForm findBySignNoTripForm(String no) {
		return signDao.findBySignNoTripForm(no);
	} // findBySignNoTripForm() end
	
	
	@Override
	public List<ProductForm> findBySignNoProductForm(String no) {
		return signDao.findBySignNoProductForm(no);
	} // findBySignNoProductForm() end
	
	
	@Override
	public ResignationForm findBySignNoResignationForm(String no) {
		return signDao.findBySignNoResignationForm(no);
	} // findBySignNoResignationForm() end
	
	
	@Override
	public int insertSignStatus(SignEntity sign) {
		int result = 0;
		String[] j1Arr = {"j1"};
		String[] j12Arr = {"j1", "j2"};
		String[] j123Arr = {"j1", "j2", "j3"};
		List<SignStatus> signStatusList = new ArrayList<>();
		
		// deptCode가 'd1'이 아닌 경우
		if (!"d1".equals(sign.getDeptCode())) {
			List<Emp> D1J12Manager = empDao.findByD1ManagerEmpList();
			Map<String, Object> param = new HashMap<>();
			param.put("deptCode", sign.getDeptCode());
			
			switch (sign.getJobCode()) {
			case "j1" :
				break;
			case "j2" :
				param.put("jobCode", j1Arr);
				List<Emp> myDeptJ1 = empDao.findByMyDeptCodeManagerEmpList(param);

				if (myDeptJ1 != null) {
					for (Emp emp : myDeptJ1)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			case "j3" :
				param.put("jobCode", j12Arr);
				List<Emp> myDeptJ12 = empDao.findByMyDeptCodeManagerEmpList(param);

				if (myDeptJ12 != null) {
					for (Emp emp : myDeptJ12)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			default :
				param.put("jobCode", j123Arr);
				List<Emp> myDeptJ123 = empDao.findByMyDeptCodeManagerEmpList(param);

				if (myDeptJ123 != null) {
					for (Emp emp : myDeptJ123)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			} // switch end

			if (D1J12Manager != null) {
				for (Emp emp : D1J12Manager)
					signStatusList.add(new SignStatus(emp.getEmpId()));
			}
		} // deptCode가 'd1'인 경우
		else {
			Map<String, Object> param = new HashMap<>();
			param.put("deptCode", sign.getDeptCode());
			
			switch (sign.getJobCode()) {
			case "j1" :
				signStatusList.add(new SignStatus(sign.getEmpId()));
				break;
			case "j2" :
				param.put("jobCode", j1Arr);
				List<Emp> myDeptJ1 = empDao.findByMyDeptCodeManagerEmpList(param);

				if (myDeptJ1 != null) {
					for (Emp emp : myDeptJ1)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			case "j3" :
				param.put("jobCode", j12Arr);
				List<Emp> myDeptJ12 = empDao.findByMyDeptCodeManagerEmpList(param);

				if (myDeptJ12 != null) {
					for (Emp emp : myDeptJ12)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			default :
				param.put("jobCode", j123Arr);
				List<Emp> myDeptJ123 = empDao.findByMyDeptCodeManagerEmpList(param);
				
				if (myDeptJ123 != null) {
					for (Emp emp : myDeptJ123)
						signStatusList.add(new SignStatus(emp.getEmpId()));
				}
				break;
			} // switch end
		} // else end
		
		for (int i = 0; i < signStatusList.size(); i++) {
			signStatusList.get(i).setSignNo(sign.getNo());
			signStatusList.get(i).setSignOrder(i + 1);
			
			if (i == 0) {
				signStatusList.get(i).setStatus(Status.W);
			} else {
				signStatusList.get(i).setStatus(Status.S);
			}
			
			result = signDao.insertSignStatus(signStatusList.get(i));
		} // for end
		
		return result;
	} // insertSignStatus() end
	
	
	@Override
	public List<Sign> findByMySignList(String empId) {
		return signDao.findByMySignList(empId);
	} // findByMySignList() end


	@Override
	public int updateMySignStatus(SignStatus signStatus) {
		return signDao.updateMySignStatus(signStatus);
	} // updateMySignStatus() end
	
	
	@Override
	public int updateNextSignStatus(String no) {
		return signDao.updateNextSignStatus(no);
	} // updateNextSignStatus() end


	@Override
	public int updateSignComplete(String no) {
		return signDao.updateSignComplete(no);
	} //updateSignComplete() end
	
	
	@Override
	public double findByEmpIdTotalCount(String empId) {
		double totalCount = 0;
		
		String _totalCount = signDao.findByEmpIdLeaveCount(empId);
		
		if (_totalCount == null) {
			totalCount = signDao.findByEmpIdBaseDayOff(empId);
		} else {
			totalCount = Double.parseDouble(_totalCount);
		}
		return totalCount;
	} // findByEmpIdTotalCount() end
	
	
	@Override
	public int deleteOneSign(Map<String, Object> param) {
		int result = signDao.deleteOneSign(param.get("no"));
		result = deleteSignStatus(param.get("no"));
		result = deleteSignForm(param);
		return result;
	} // deleteOneSign() end
	
	
	@Override
	public int deleteSignStatus(Object no) {
		return signDao.deleteSignStatus(no);
	} // deleteSignStatus() end
	
	
	@Override
	public int deleteSignForm(Map<String, Object> param) {
		return signDao.deleteSignForm(param);
	} // deleteSignForm() end
	
	
	@Override
	public List<Sign> findByEmpIdMySignStatus(Map<String, Object> param) {
		return signDao.findByEmpIdMySignStatus(param);
	} // findByEmpIdMySignStatus() end
	
	
	@Override
	public List<Map<String, Object>> findByEmpIdToBeNoDateDayOff(String empId) {
		return signDao.findByEmpIdToBeNoDateDayOff(empId);
	} // findByEmpIdToBeNoDateDayOff() end
	
	
	@Override
	public List<Map<String, Object>> findByEmpIdToBeNoDateTrip(String empId) {
		return signDao.findByEmpIdToBeNoDateTrip(empId);
	} // findByEmpIdToBeNoDateTrip() end
	
} // class end
