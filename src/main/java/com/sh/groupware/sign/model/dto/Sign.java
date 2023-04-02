package com.sh.groupware.sign.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.report.model.dto.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Sign extends SignEntity {

	private String name;
	private String deptTitle;
	private String jobTitle;
	private String profileImg;
	List<SignStatusDetail> signStatusList = new ArrayList<>();
	
	public void addSignStatus(SignStatusDetail signStatus) {
		this.signStatusList.add(signStatus);
	} // addSignStatus() end

	public Sign(String no, String empId, String deptCode, String jobCode, SignType type, LocalDate regDate,
			YN emergency, YN complete, String name, String deptTitle, String jobTitle,
			String profileImg, List<SignStatusDetail> signStatusList) {
		super(no, empId, deptCode, jobCode, type, regDate, emergency, complete);
		this.name = name;
		this.deptTitle = deptTitle;
		this.jobTitle = jobTitle;
		this.profileImg = profileImg;
		this.signStatusList = signStatusList;
	} // Sign() end
	
} // class end
