package com.travel.mapper;

import com.travel.dto.MemberDTO;

public interface MemberMapper {

	void insertMember(MemberDTO member);

	MemberDTO selectMemberByUserId(String userId);
	
	MemberDTO selectMemberByUserId(int memberId);

}
