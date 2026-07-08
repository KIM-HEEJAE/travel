package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.MemberDTO;
import com.travel.dto.PreferenceDTO;
import com.travel.service.PreferenceService;

@Controller
public class PreferenceController {

    @Autowired
    private PreferenceService preferenceService;

    // 취향 설문 폼
    @RequestMapping("/preference/survey")
    public String surveyForm(HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        return "preference/survey";
    }

    // 취향 설문 등록 처리
    @RequestMapping("/preference/save")
    public String save(PreferenceDTO pref, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        pref.setMemberId(loginMember.getMemberId());
        preferenceService.savePreference(pref);
        return "redirect:/preference/dashboard";
    }

    // 대시보드 화면
    @RequestMapping("/preference/dashboard")
    public String dashboard() {
        return "preference/dashboard";
    }

    // 대시보드용 데이터 Ajax API (JSON 응답)
    @RequestMapping("/preference/statsData")
    @ResponseBody
    public Map<String, Object> statsData() {
        Map<String, Object> result = new HashMap<>();
        result.put("styleStats", preferenceService.getStyleStats());
        result.put("budgetStats", preferenceService.getBudgetStats());
        result.put("domesticStats", preferenceService.getDomesticStats());
        result.put("popularRegions", preferenceService.getPopularRegions());
        return result;
    }
}