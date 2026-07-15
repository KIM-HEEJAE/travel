package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.ChatDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.ChatService;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    // 챗봇 페이지
    @RequestMapping("/ask")
    public String chatPage() {
        return "chat/ask";
    }

    // 질문 처리 (Ajax)
    @RequestMapping("/send")
    @ResponseBody
    public Map<String, String> send(@RequestParam("question") String question, HttpSession session) {
        Map<String, String> result = new HashMap<>();
        String answer = chatService.askGemini(question);
        result.put("answer", answer);
        
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if(loginMember != null) {
        	chatService.saveChatLog(loginMember.getMemberId(),question,answer);
        }
        return result;
    }
    @RequestMapping("/history")
    public String history(HttpSession session, Model model) {
    	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
    	if(loginMember==null) {
    		return "redirect:/member/login";
    	}
    	List<ChatDTO> myChats = chatService.getMyChats(loginMember.getMemberId());
    	model.addAttribute("myChats",myChats);
    	return "chat/history";
    }
    
}