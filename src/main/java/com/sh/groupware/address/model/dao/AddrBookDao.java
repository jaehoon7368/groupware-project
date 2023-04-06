package com.sh.groupware.address.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.sh.groupware.address.model.dto.AddressBook;
import com.sh.groupware.address.model.dto.AddressGroup;
import com.sh.groupware.common.dto.Attachment;
import com.sh.groupware.emp.model.dto.Emp;

@Mapper
public interface AddrBookDao {

	int insertAddrbook(AddressBook addressBook);

	int insertAttachment(Attachment attach);

	List<AddressGroup> findByGroupType(String groupType);

	List<Emp> selectEmpList(RowBounds rowBounds);
	
	int selectAddressBookCount();

	List<AddressBook> selectAllAddrBookList(String empId);

	int insertAddrGroup(AddressGroup addressGroup);

	List<AddressGroup> selectGroupName(String empId);

	List<AddressGroup> selectAddrBookListByGroupName(String groupName);

	List<AddressGroup> findByEmpId(String empId);

	AddressBook selectOneAddrCollection(String addrNo);

	int updateAddrBook(AddressBook addressBook);

	List<AddressBook> selectAddrBooklistByPage(String empId, RowBounds rowBounds);

	int selectAddressBookCountById(String empId);

	List<AddressBook> filterNamesByKeyword(String keyword);

	List<AddressBook> selectAddrsByNos(List<String> addrNos);

	int deleteAddrs(List<String> addrNos);

	AddressBook selectAddrByNo(String addrNo);

	int deleteAddr(String addrNo);

}
