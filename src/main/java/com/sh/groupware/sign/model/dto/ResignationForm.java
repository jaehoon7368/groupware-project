package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResignationForm {

	private String no;
	private String signNo;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private LocalDate endDate;
	private String reason;
	
} // class end
