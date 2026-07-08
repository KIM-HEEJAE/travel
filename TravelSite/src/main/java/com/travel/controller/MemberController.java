package com.travel.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.MemberDTO;
import com.travel.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/join")
	public String joinForm() {
		return "member/join";
	}
	
	@RequestMapping("/joinProc")
	public String joinProc(MemberDTO member, Model model) {
		if (memberService.isUserIdDuplicate(member.getUserId())) {
			model.addAttribute("error", "이미 사용중인 아이디입니다.");
			return "member/join";
		}
		memberService.join(member);
		return "redirect:/member/login";
	}

	@RequestMapping("/checkUserId")
	@ResponseBody
	public boolean checkUserId(@RequestParam("userId") String userId) {
		return memberService.isUserIdDuplicate(userId);
	}
	
	// 이 부분이 빠져있었어요!
	@RequestMapping("/login")
	public String loginForm() {
		return "member/login";
	}
	
	@RequestMapping("/loginProc")
	public String loginProc(@RequestParam("userId") String userId, @RequestParam("password") String password, HttpSession session, Model model) {
		MemberDTO member = memberService.login(userId,password);
		if(member != null) {
			session.setAttribute("loginMember",member);
			return "redirect:/board/list";
		}else {
			model.addAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "member/login";  // 여기 앞에 "/" 있었던 것도 지웠어요
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/board/list";
	}
}