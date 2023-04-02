package com.sh.groupware.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.common.dao.CommonDao;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.common.dto.RecentNotification;
import com.sh.groupware.emp.model.dto.Emp;
import com.sh.groupware.todo.model.dao.TodoDao;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonDao commonDao;
	@Autowired
	private TodoDao todoDao;

	@Override
	public List<RecentNotification> selectAllReNoti() {
		List<RecentNotification> reNotis = commonDao.selectAllReNoti();
		log.debug(" DAo 테스트");
		log.debug(" DAo reNotis {}", reNotis);

		  for(RecentNotification reNoti : reNotis) { 
		String empId = reNoti.getEmpId();
		  Attachment attachment = todoDao.selectOneAttachmentByEmpId(empId); 
		  Emp emp = commonDao.selectOneEmpTitleJobByEmpId(empId);
		  
		  reNoti.setAttachment(attachment); reNoti.setEmp(emp); }
		 
		return reNotis;
	}

}
