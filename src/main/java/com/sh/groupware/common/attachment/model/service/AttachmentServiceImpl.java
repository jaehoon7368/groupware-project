package com.sh.groupware.common.attachment.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.groupware.common.attachment.model.dao.AttachmentDao;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.todo.model.dao.TodoDao;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class AttachmentServiceImpl implements AttachmentService {

	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private TodoDao todoDao;
	
	
	@Override
	public Attachment selectEmpProfile(String empId) {
		return attachmentDao.selectEmpProfilr(empId);
	}
	@Override
	public int todoFileUpload(Attachment attachment) {
		int resultattach = attachmentDao.todoFileUpload(attachment); 
		
		
		String attachNo = attachment.getNo();
		log.debug(attachNo);
		
		int result1 = todoDao.updateTodoFileUpload(attachNo);
		
		
		return resultattach;
	}
	
}
