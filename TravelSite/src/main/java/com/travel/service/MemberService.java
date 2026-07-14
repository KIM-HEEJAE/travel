package com.travel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.travel.dto.MemberDTO;
import com.travel.mapper.MemberMapper;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public boolean isUserIdDuplicate(String userId) {
        return memberMapper.selectMemberByUserId(userId) != null;
    }

    // 회원가입 - 비밀번호 암호화 후 저장
    public void join(MemberDTO member) {
        String encodedPassword = passwordEncoder.encode(member.getPassword());
        member.setPassword(encodedPassword);
        memberMapper.insertMember(member);
    }

    // 로그인 - 암호화된 비밀번호와 매칭 확인
    public MemberDTO login(String userId, String password) {
        MemberDTO member = memberMapper.selectMemberByUserId(userId);
        if (member != null && passwordEncoder.matches(password, member.getPassword())) {
            return member;
        }
        return null;
    }

    public MemberDTO getMember(int memberId) {
        return memberMapper.selectMemberById(memberId);
    }
    // 회원정보 수정
    public void updateInfo(MemberDTO member) {
        memberMapper.updateMemberInfo(member);
    }

    // 비밀번호 변경 - 현재 비밀번호 확인 후 변경
    public boolean changePassword(int memberId, String currentPassword, String newPassword) {
        MemberDTO member = memberMapper.selectMemberById(memberId);
        if (member == null || !passwordEncoder.matches(currentPassword, member.getPassword())) {
            return false; // 현재 비밀번호 불일치
        }
        MemberDTO updateData = new MemberDTO();
        updateData.setMemberId(memberId);
        updateData.setPassword(passwordEncoder.encode(newPassword));
        memberMapper.updatePassword(updateData);
        return true;
    }
}