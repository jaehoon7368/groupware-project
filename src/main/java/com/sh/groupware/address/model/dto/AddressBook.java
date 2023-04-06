package com.sh.groupware.address.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper = true)
public class AddressBook {
	private List<Attachment> attachments = new ArrayList<>();
	private int attachCount;
	private Emp emp;
	
	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	}
	
	private String addrNo;
	private String name;
	private String jobName;
	private String phone;
	private String deptTitle;
	private String company;
	private String cpTel;
	private String cpAddress;
	private String email;
	private LocalDateTime regDate;
	private String memo;
	private String groupName;
	private GroupType groupType;
	private String writer;

	public AddressBook(List<Attachment> attachments, int attachCount) {
		super();
		this.attachments = attachments;
		this.attachCount = attachCount;
	}

	public AddressBook(Emp emp) {
		super();
		this.emp = emp;
	}
	
	
}
