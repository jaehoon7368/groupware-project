package com.sh.groupware.report.model.dto;

import java.time.LocalDate;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class ReportCheck extends ReportMember {

	private String title;
	private String writer;
	private LocalDate endDate;
	private YN publicYn;
	private YN deptYn;
	private int totalMemberCount;
	private int memberCount;
	private int createCount;
	private String empName;
	private String jobTitle;
	private String deptTitle;

	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, String name,
			String jobTitle, String deptTitle, int totalMemberCount, int memberCount, int createCount) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.totalMemberCount = totalMemberCount;
		this.memberCount = memberCount;
		this.createCount = createCount;
	} // ReportCheck() end

	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, String name,
			String jobTitle, String deptTitle, String title, String writer, LocalDate endDate, YN publicYn, YN deptYn,
			int totalMemberCount, int memberCount, int createCount) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.title = title;
		this.writer = writer;
		this.endDate = endDate;
		this.publicYn = publicYn;
		this.deptYn = deptYn;
		this.totalMemberCount = totalMemberCount;
		this.memberCount = memberCount;
		this.createCount = createCount;
	} // ReportCheck() end
	
}
