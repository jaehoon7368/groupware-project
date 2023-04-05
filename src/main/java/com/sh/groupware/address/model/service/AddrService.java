package com.sh.groupware.address.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.address.model.dto.AddressBook;
import com.sh.groupware.address.model.dto.AddressGroup;
import com.sh.groupware.emp.model.dto.Emp;

public interface AddrService {

	int insertAddrbook(AddressBook addressBook);

	List<AddressGroup> findByGroupType(String groupType);

	List<Emp> selectEmpList(RowBounds rowBounds);

	int selectAddressBookCount();

	List<AddressBook> selectAllAddrBookList(String empId);

	int insertAddrGroup(AddressGroup addressGroup);

	List<AddressGroup> selectGroupName(String empId);

	List<AddressGroup> selectAddrBookListByGroupName(String groupName);

}
