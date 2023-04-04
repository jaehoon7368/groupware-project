package com.sh.groupware.address.model.dto;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddressBook {

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
}
