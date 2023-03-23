package com.sh.groupware.common.attachment.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
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
	@Insert("insert into attachment values (seq_attachment_no.nextval, #{originalFilename}, #{renameFilename}, default, #{category}, #{pkNo})")
	int insertReportAttachment(Attachment attach);

	@Select("select * from attachment where category = #{category} and pk_no = #{pkNo}")
	List<Attachment> selectAllAttachList(Map<String, Object> param);

	@Select("select * from attachment where no = #{no}")
	Attachment selectOneAttachment(int no);

}
