package com.sh.groupware.emp.model.dto;

import java.time.LocalDate;
import com.sh.groupware.common.dto.Attachment;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class EmpDetail extends Emp {

	private String jobTitle;
	private int baseDayOff;
	private String deptTitle;
	private String renameFilename; // profile 
	private List<Authority> authorityList = new ArrayList<>();
	
	
	
	
	public EmpDetail(String empId, String password, String name, String ssn, String address, String email, String phone,
			LocalDate hireDate, LocalDate quitDate, Quit quitYn, String jobCode, String deptCode,
			List<SimpleGrantedAuthority> authorities,Attachment attachment,String jobTitle, int baseDayOff, String deptTitle) {
		super(empId, password, name, ssn, address, email, phone, hireDate, quitDate, quitYn, jobCode, deptCode,
				authorities, attachment);
		this.jobTitle = jobTitle;
		this.baseDayOff = baseDayOff;
		this.deptTitle = deptTitle;
	} // EmpDetail() end
	
	
	public EmpDetail(String empId, String password, String name, String ssn, String address, String email, String phone,
			LocalDate hireDate, LocalDate quitDate, Quit quitYn, String jobCode, String deptCode,
			List<SimpleGrantedAuthority> authorities, Attachment attachment,String jobTitle, int baseDayOff, String deptTitle,
			List<Authority> authorityList) {
		super(empId, password, name, ssn, address, email, phone, hireDate, quitDate, quitYn, jobCode, deptCode,
				authorities,attachment);
		this.jobTitle = jobTitle;
		this.baseDayOff = baseDayOff;
		this.deptTitle = deptTitle;
		this.authorityList = authorityList;
	} // EmpDetail() end
	
	
	public void addAuthorityList(Authority auth) {
		this.authorityList.add(auth);
	}


	public EmpDetail(String empId, String password, String name, String ssn, String address, String email, String phone,
			LocalDate hireDate, LocalDate quitDate, Quit quitYn, String jobCode, String deptCode,
			List<SimpleGrantedAuthority> authorities, Attachment attachment, String jobTitle, String deptTitle,
			String renameFilename) {
		super(empId, password, name, ssn, address, email, phone, hireDate, quitDate, quitYn, jobCode, deptCode,
				authorities, attachment);
		this.jobTitle = jobTitle;
		this.deptTitle = deptTitle;
		this.renameFilename = renameFilename;
	} // addAuthorityList() end
	
} // class end

