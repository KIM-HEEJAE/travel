package com.travel.mapper;

import com.travel.dto.MemberDTO;

public interface MemberMapper {

	void insertMember(MemberDTO member);

	MemberDTO selectMemberByUserId(String userId);
	
    MemberDTO selectMemberById(int memberId);  // 이름 수정

    // 회원정보 수정 (이름, 이메일)
    void updateMemberInfo(MemberDTO member);

    // 비밀번호 변경
    void updatePassword(MemberDTO member);
}
