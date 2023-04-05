package com.sh.groupware.address.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.sh.groupware.common.dto.Attachment;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper = true)
public class AddressGroup {

	private String no;
	private String empId;
	private String groupNo;
	private String groupName;
	private GroupType groupType;

}
