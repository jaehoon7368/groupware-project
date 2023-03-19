package com.sh.groupware.report.model.dto;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Report {

	private List<ReportMember> memberList;
	private List<Reference> referenceList;
	
	public void addReportMember(ReportMember member) {
		this.memberList.add(member);
	} // addReportMember() end
	
	public void addReference(Reference refer) {
		this.referenceList.add(refer);
	} // addReference() end
	
} // class end
