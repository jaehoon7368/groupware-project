package com.sh.groupware.sign.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductForm {

	private String no;
	private String signNo;
	private String name;
	private long amount;
	private long price;
	private long totalPrice;
	private String purpose;
	
	private List<ProductForm> productFormList;
	
} // class end
