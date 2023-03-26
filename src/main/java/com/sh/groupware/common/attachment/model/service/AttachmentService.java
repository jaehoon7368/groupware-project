package com.sh.groupware.common.attachment.model.service;

import java.util.List;
import java.util.Map;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.todo.model.dto.Todo;

public interface AttachmentService {


	Attachment selectEmpProfile(String empId);

	int todoFileUpload(Attachment attach);

	List<Attachment> selectAllAttachList(Map<String, Object> param);

	Attachment selectOneAttachment(String noFile);

	int deleteOneAttachment(String no);
}
