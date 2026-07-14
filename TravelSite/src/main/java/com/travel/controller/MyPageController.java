package com.travel.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.travel.dto.BoardDTO;
import com.travel.dto.MemberDTO;
import com.travel.dto.PreferenceDTO;
import com.travel.service.BoardService;
import com.travel.service.MemberService;
import com.travel.service.PreferenceService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private PreferenceService preferenceService;
    
    @Autowired
    private MemberService memberService;

    @RequestMapping("")
    public String myPage(HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 내가 쓴 글 목록
        List<BoardDTO> myBoards = boardService.getMyBoards(loginMember.getMemberId());
        model.addAttribute("myBoards", myBoards);

        // 내 취향 정보 (없을 수도 있음)
        PreferenceDTO myPref = preferenceService.getPreference(loginMember.getMemberId());
        model.addAttribute("myPref", myPref);

        model.addAttribute("member", loginMember);

        return "mypage/index";
    }
    
 // 회원정보 수정 폼
    @RequestMapping("/editInfo")
    public String editInfoForm(HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        MemberDTO member = memberService.getMember(loginMember.getMemberId());
        model.addAttribute("member", member);
        return "mypage/editInfo";
    }

    // 회원정보 수정 처리
    @RequestMapping("/editInfoProc")
    public String editInfoProc(@RequestParam("name") String name,
                                @RequestParam("email") String email,
                                HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        MemberDTO updateData = new MemberDTO();
        updateData.setMemberId(loginMember.getMemberId());
        updateData.setName(name);
        updateData.setEmail(email);
        memberService.updateInfo(updateData);

        // 세션 정보도 갱신 (이름이 헤더 등에 바로 반영되도록)
        loginMember.setName(name);
        loginMember.setEmail(email);
        session.setAttribute("loginMember", loginMember);

        return "redirect:/mypage";
    }

    // 비밀번호 변경 폼
    @RequestMapping("/changePassword")
    public String changePasswordForm(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        return "mypage/changePassword";
    }

    // 비밀번호 변경 처리
    @RequestMapping("/changePasswordProc")
    public String changePasswordProc(@RequestParam("currentPassword") String currentPassword,
                                      @RequestParam("newPassword") String newPassword,
                                      @RequestParam("newPasswordCheck") String newPasswordCheck,
                                      HttpSession session,
                                      Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        if (!newPassword.equals(newPasswordCheck)) {
            model.addAttribute("error", "새 비밀번호가 일치하지 않습니다.");
            return "mypage/changePassword";
        }

        boolean success = memberService.changePassword(loginMember.getMemberId(), currentPassword, newPassword);
        if (!success) {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "mypage/changePassword";
        }

        return "redirect:/mypage";
    }
}