package com.sh.groupware.report.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Report extends ReportEntity {

	private List<String> referenceDept = new ArrayList<>();
	
	private List<ReportMember> memberList = new ArrayList<>();
	private List<Reference> referenceList = new ArrayList<>();
	
	public Report(String no, String writer, String title, String explain, LocalDate regDate, YN publicYn) {
		super(no, writer, title, explain, regDate, publicYn);
	} // Report() end
	
	public void addReportMember(ReportMember member) {
		this.memberList.add(member);
	} // addReportMember() end
	
	public void addReference(Reference refer) {
		this.referenceList.add(refer);
	} // addReference() end
	
} // class end
