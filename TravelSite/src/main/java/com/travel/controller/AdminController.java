package com.travel.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.travel.dto.MemberDTO;
import com.travel.service.BoardService;
import com.travel.service.FlightService;
import com.travel.service.HotelService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private FlightService flightService;

    @Autowired
    private HotelService hotelService;

    @Autowired
    private BoardService boardService;

    // 관리자 권한 체크 (공통으로 재사용)
    private boolean isAdmin(HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        return loginMember != null && "Y".equals(loginMember.getIsAdmin());
    }

    // 관리자 대시보드
    @RequestMapping("")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        int flightCount = flightService.getFlightList(new java.util.HashMap<>()).size();
        int hotelCount = hotelService.getHotelList(new java.util.HashMap<>()).size();

        model.addAttribute("flightCount", flightCount);
        model.addAttribute("hotelCount", hotelCount);

        return "admin/dashboard";
    }
}