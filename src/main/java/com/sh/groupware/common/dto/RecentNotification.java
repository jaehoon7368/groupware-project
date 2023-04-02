package com.sh.groupware.common.dto;

import java.time.LocalDateTime;

import com.sh.groupware.emp.model.dto.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecentNotification {

	private String no;
	private String pkNo;
	private String empId;
	private LocalDateTime regDate;
	private Emp emp;
	private Attachment attachment;
	private long hour;
	private long min;
	
	
	
	
	
}