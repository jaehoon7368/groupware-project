package com.sh.groupware.report.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportDetail {
	
	private String no;
	@NonNull
	private String reportNo;
	@NonNull
	private String empId;
	@NonNull
	private String content;
	private LocalDate regDate;

	private List<Attachment> attachments = new ArrayList<>();
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	} // addAttachment() end
	
} // class end
