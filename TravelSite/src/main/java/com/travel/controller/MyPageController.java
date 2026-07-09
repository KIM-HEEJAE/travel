package com.travel.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.travel.dto.BoardDTO;
import com.travel.dto.MemberDTO;
import com.travel.dto.PreferenceDTO;
import com.travel.service.BoardService;
import com.travel.service.PreferenceService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private PreferenceService preferenceService;

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
}