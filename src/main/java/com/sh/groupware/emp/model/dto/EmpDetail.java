package com.sh.groupware.emp.model.dto;

import java.time.LocalDate;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.sh.groupware.common.dto.Attachment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class EmpDetail extends Emp {

	private String deptTitle;
	private String jobTitle;
	public EmpDetail(String empId, String password, String name, String ssn, String address, String email, String phone,
			LocalDate hireDate, LocalDate quitDate, Quit quitYn, String jobCode, String deptCode,
			List<SimpleGrantedAuthority> authorities, Attachment attachment, String deptTitle, String jobTitle) {
		super(empId, password, name, ssn, address, email, phone, hireDate, quitDate, quitYn, jobCode, deptCode,
				authorities, attachment);
		this.deptTitle = deptTitle;
		this.jobTitle = jobTitle;
	}
	
	
	
	
	
	
	
}
