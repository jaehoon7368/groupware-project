package com.sh.groupware.emp.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.common.attachment.model.dao.AttachmentDao;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dao.EmpDao;
import com.sh.groupware.emp.model.dto.Authority;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.emp.model.dto.EmpDetail;
import com.sh.groupware.report.model.dto.ReportMember;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDao empDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	
	@Override
	public Emp selectEmp() {
		return empDao.selectEmp();
	}
	
	@Override
	public int insertEmp(Emp emp) {
		// 직원추가
		int result = empDao.insertEmp(emp);
		
		// 직원 권한부여
		String jobCode = emp.getJobCode(); //회원 jobCode
		String jobAuthority = null;
		String deptCode = emp.getDeptCode(); //회원 deptCode
		String deptAuthority = null;
		
		switch(jobCode) {
			case "j1" : jobAuthority = "ROLE_EXECUTIVE"; break;
			case "j2" : jobAuthority = "ROLE_EXECUTIVE"; break;
			case "j3" : jobAuthority = "ROLE_MANAGER"; break;
			default : jobAuthority = null;
		}
		
		switch(deptCode) {
			case "d1" : deptAuthority = "ROLE_PERSONNEL"; break;
			case "d2" : deptAuthority = "ROLE_DEVELOPMENT"; break;
			case "d3" : deptAuthority = "ROLE_LEGAL"; break;
			case "d4" : deptAuthority = "ROLE_MARKETING"; break;
			case "d5" : deptAuthority = "ROLE_PLANNING"; break;
			default : deptAuthority = null;
		}
		
		List<String> authorities = new ArrayList<>();
		authorities.add("ROLE_USER");
		
		if(jobAuthority != null)
			authorities.add(jobAuthority);
		
		if(deptAuthority != null)
			authorities.add(deptAuthority);
		
		
		for(String str : authorities) {
			String empId = emp.getEmpId(); //회원 pk
			Map<String,Object> param = new HashMap<>();
			param.put("empId", empId);
			param.put("auth",str);
			result = empDao.insertAuthority(param);
		}
		Attachment attach = emp.getAttachment();
		result = attachmentDao.insertProfile(attach);
		
		return result;
	}
	
	@Override
	public EmpDetail selectEmpDetail(String empId) {
		return empDao.selectEmpDetail(empId);
	}
	
	@Override
	public List<EmpDetail> selectAllEmpList() {
		List<EmpDetail> empList = empDao.selectAllEmpList();
		
		for (EmpDetail emp : empList) {
			List<Authority> authorityList = empDao.selectAllAuthorityList(emp.getEmpId());
			
			if (authorityList.size() > 0) {
				for (Authority authority : authorityList)
					emp.addAuthorityList(authority);
			}
			
			Attachment attach = attachmentDao.selectEmpProfilr(emp.getEmpId());
			emp.setAttachment(attach);
		}
		log.debug("empList = {}", empList);
		return empList;
	} // selectAllEmpList() end
	
	@Override
	public List<Emp> findByDeptCodeEmpList(String deptCode) {
		return empDao.findByDeptCodeEmpList(deptCode);
	} // findByDeptCodeEmpList() end
	
	@Override
	public List<Emp> findByDeptCodeEmpIdEmpList(Map<String, Object> param) {
		return empDao.findByDeptCodeEmpIdEmpList(param);
	} // findByDeptCodeEmpIdEmpList() end
	
	@Override
	public int empUpdate(Emp emp) {
		return empDao.empUpdate(emp);
	}
	public List<Emp> selectAllEmpAddTitleDept() {
		return empDao.selectAllEmpAddTitleDept();
	}
	
	@Override
	public int updateQuit(Map<String, Object> param) {
		return empDao.updateQuit(param);
	} // updateQuit() end
	
	@Override
	public List<EmpDetail> selectEmpDeptList(String deptCode) {
		return empDao.selectEmpDeptList(deptCode);
	}
	
	@Override
	public List<EmpDetail> selectEmpAll() {
		return empDao.selectEmpAll();
	}
}
