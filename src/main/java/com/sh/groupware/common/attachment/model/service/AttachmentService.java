package com.sh.groupware.common.attachment.model.service;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.todo.model.dto.Todo;

public interface AttachmentService {


	Attachment selectEmpProfile(String empId);

	int todoFileUpload(Attachment attach);

}
