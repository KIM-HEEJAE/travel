package com.travel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.MemberDTO;
import com.travel.mapper.MemberMapper;
@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;
	public boolean isUserIdDuplicate(String userId) {
		// TODO Auto-generated method stub
		return memberMapper.selectMemberByUserId(userId) !=null;
	}

	public void join(MemberDTO member) {
		 memberMapper.insertMember(member);
		
	}

	public MemberDTO login(String userId, String password) {
		MemberDTO member= (MemberDTO) memberMapper.selectMemberByUserId(userId);
		if(member!=null && member.getPassword().equals(password)) {
			return member;
		}
		return null;
	}
	public MemberDTO getMember(int memberId) {
		return memberMapper.selectMemberByUserId(memberId);
	}
}
