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
public class AddressSubMenu {

	private String no;
	private String groupNo;
	private String name;

}
