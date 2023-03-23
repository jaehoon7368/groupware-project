package com.sh.groupware.common.attachment.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.groupware.common.dto.Attachment;

@Mapper
public interface AttachmentDao {

	int insertProfile(Attachment attach);

	@Select("select * from attachment where pk_no = #{empId}")
	Attachment selectEmpProfilr(String empId);

	

	int todoFileUpload(Attachment attachment);

	int updateTodoFileUpload(String attachNo);

}
