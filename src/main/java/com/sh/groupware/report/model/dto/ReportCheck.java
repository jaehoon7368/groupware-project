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
	private String deptTitle;
	private int memberCount;
	private int createCount;
	
	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, int memberCount,
			int createCount) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.memberCount = memberCount;
		this.createCount = createCount;
	} // ReportCheck() end

	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, String title, String writer,
			LocalDate endDate, YN publicYn, YN deptYn, String deptTitle, int memberCount, int createCount) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.title = title;
		this.writer = writer;
		this.endDate = endDate;
		this.publicYn = publicYn;
		this.deptYn = deptYn;
		this.deptTitle = deptTitle;
		this.memberCount = memberCount;
		this.createCount = createCount;
	} // ReportCheck() end
	
}
