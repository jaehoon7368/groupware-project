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
	
	@Autowired
	private DayOffDao dayOffDao;
	
	@Autowired
	private WorkingManagementDao workingDao;
	
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
	public int insertSignResignationForm(ResignationForm resignation, SignEntity sign) {
		int result = signDao.insertSign(sign);
		resignation.setSignNo(sign.getNo());
		
		result = insertResignationForm(resignation);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSignResignationForm() end

	
	@Override
	public int insertResignationForm(ResignationForm resignation) {
		return signDao.insertResignationForm(resignation);
	} // insertResignationForm() end
	
	
	@Override
	public int insertSignProductForm(ProductForm productForm, SignEntity sign) {
		int result = signDao.insertSign(sign);
		productForm.setSignNo(sign.getNo());
		
		result = insertProductForm(productForm);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSignProductForm() end
	
	
	@Override
	public int insertProductForm(ProductForm productForm) {
		return signDao.insertProductForm(productForm);
	} // insertProductForm() end


	@Override
	public List<Sign> findByMyCreateSignList(String empId) {
		return signDao.findByMyCreateSignList(empId);
	} // findByMyCreateSignList() end
	
	
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
	public ProductForm findBySignNoProductForm(String no) {
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
	public int signStatusUpdate(SignStatus signStatus) {
		int result = 0;
		
		Sign sign = signDao.findByNoSign(signStatus.getSignNo());
		List<SignStatusDetail> signStatusList = sign.getSignStatusList();
		
		for (int i = 0; i < signStatusList.size(); i++) {
			if (signStatus.getEmpId().equals(signStatusList.get(i).getEmpId())) {
				// 내 결제 상태 업데이트
				result = updateMySignStatus(signStatus);
				
				// 내가 마지막 결재자인 경우
				if (i == signStatusList.size() - 1) {
					result = updateSignComplete(sign.getNo());
					
					// 결재 양식에 따라 해당 테이블 업데이트
					switch (sign.getType()) {
					case D:
						DayOffForm dayOffForm = findBySignNoDayOffForm(sign.getNo());
						double leaveCount = findByEmpIdTotalCount(sign.getEmpId());
						DayOff dayOff = new DayOff(
							null, 
							signStatus.getEmpId(), 
							dayOffForm.getStartDate().getYear(),
							dayOffForm.getStartDate(),
							dayOffForm.getEndDate(),
							dayOffForm.getCount(),
							leaveCount - dayOffForm.getCount(),
							null
						);
						
						result = dayOffDao.insertDayOff(dayOff);
						break;
					case T:
						TripForm trip = findBySignNoTripForm(sign.getNo());
						WorkingManagement working = new WorkingManagement();
						working.setState("출장");
						working.setEmpId(signStatus.getEmpId());
						
						int betweenDays = (int) Duration.between(trip.getStartDate().atStartOfDay(), trip.getEndDate().atStartOfDay()).toDays();
						log.debug("betweenDays = {}", betweenDays);
						
						working.setRegDate(trip.getStartDate());
						result = workingDao.insertRegDateState(working);
						
						if (betweenDays > 1) {
							for (int j = 1; j < betweenDays; j++) {
								working.setRegDate(trip.getStartDate().plusDays(j));
								result = workingDao.insertRegDateState(working);
							}
						}
						
						break;
					case R:
						ResignationForm resignation = findBySignNoResignationForm(sign.getNo());
						
						Map<String, Object> param = new HashMap<>();
						param.put("endDate", resignation.getEndDate());
						param.put("empId", signStatus.getEmpId());
						
						result = empDao.updateQuit(param);
						break;
					} // switch end
					
				} // if end
				// 내가 마지막 결재자가 아닌 경우
				else {
					// 결재인 경우에만 다음 결재자 결재 상태 업데이트
					if (Status.C == signStatus.getStatus()) {
						result = updateNextSignStatus(signStatusList.get(i + 1).getNo());
					} // if end
				} // else end
				
			} // if end
		} // for end
		
		return result;
	} // signStatusUpdate() end


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
	
} // class end
