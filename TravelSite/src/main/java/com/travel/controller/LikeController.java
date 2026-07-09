package com.travel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.MemberDTO;
import com.travel.service.LikeService;

@Controller
@RequestMapping("/like")
public class LikeController {

    @Autowired
    private LikeService likeService;

    @RequestMapping("/toggle")
    @ResponseBody
    public Map<String, Object> toggle(@RequestParam("boardId") int boardId, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        Map<String, Object> result = new HashMap<>();

        if (loginMember == null) {
            result.put("error", "login_required");
            return result;
        }

        return likeService.toggleLike(boardId, loginMember.getMemberId());
    }
}