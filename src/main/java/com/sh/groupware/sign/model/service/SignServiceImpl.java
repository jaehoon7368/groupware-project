package com.sh.groupware.sign.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.emp.model.dao.EmpDao;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.sign.model.dao.SignDao;
import com.sh.groupware.sign.model.dto.DayOffForm;
import com.sh.groupware.sign.model.dto.ResignationForm;
import com.sh.groupware.sign.model.dto.Sign;
import com.sh.groupware.sign.model.dto.SignEntity;
import com.sh.groupware.sign.model.dto.SignStatus;
import com.sh.groupware.sign.model.dto.Status;

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
	public int insertSign(DayOffForm dayOffForm, SignEntity sign) {
		int result = signDao.insertSign(sign);
		dayOffForm.setSignNo(sign.getNo());
		
		result = insertDayOffForm(dayOffForm);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSign() end

	
	@Override
	public int insertDayOffForm(DayOffForm dayOffForm) {
		return signDao.insertDayOffForm(dayOffForm);
	} // insertDayOffForm() end
	
	
	@Override
	public List<Sign> findByMyCreateSignList(String empId) {
		return signDao.findByMyCreateSignList(empId);
	} // findByMyCreateSignList() end
	
	
	@Override
	public int insertSign(ResignationForm resignation, SignEntity sign) {
		int result = signDao.insertSign(sign);
		resignation.setSignNo(sign.getNo());
		
		result = insertResignationForm(resignation);
		
		result = insertSignStatus(sign);
		
		return result;
	} // insertSign() end

	
	@Override
	public int insertResignationForm(ResignationForm resignation) {
		return signDao.insertResignationForm(resignation);
	} // insertResignationForm() end
	
	
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
				signStatusList.get(i).setStatus(Status.S);
			} else {
				signStatusList.get(i).setStatus(Status.W);
			}
			
			result = signDao.insertSignStatus(signStatusList.get(i));
		} // for end
		
		return result;
	} // insertSignStatus() end
	
} // class end
