package com.sh.groupware.report.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;

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
	private int createCount;
	private int noCreateCount;
	private String empName;
	private String jobTitle;
	private String deptTitle;
	private String detailNo;
	private String content;
	private LocalDate createDate;
	
	private List<Attachment> attachments = new ArrayList<>();
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	} // addAttachment() end

	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, String title, String writer,
			LocalDate endDate, YN publicYn, YN deptYn, int totalMemberCount, int createCount, int noCreateCount,
			String empName, String jobTitle, String deptTitle, String detailNo, String content, LocalDate createDate) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.title = title;
		this.writer = writer;
		this.endDate = endDate;
		this.publicYn = publicYn;
		this.deptYn = deptYn;
		this.totalMemberCount = totalMemberCount;
		this.createCount = createCount;
		this.noCreateCount = noCreateCount;
		this.empName = empName;
		this.jobTitle = jobTitle;
		this.deptTitle = deptTitle;
		this.detailNo = detailNo;
		this.content = content;
		this.createDate = createDate;
	} // ReportCheck() end

	public ReportCheck(String no, String reportNo, String empId, YN createYn, YN excludeYn, int totalMemberCount,
			int createCount, int noCreateCount) {
		super(no, reportNo, empId, createYn, excludeYn);
		this.totalMemberCount = totalMemberCount;
		this.createCount = createCount;
		this.noCreateCount = noCreateCount;
	} // ReportCheck() end
	
} // class end
