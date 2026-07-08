package com.travel.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public Map<String, String> send(@RequestParam("question") String question) {
        Map<String, String> result = new HashMap<>();
        String answer = chatService.askGemini(question);
        result.put("answer", answer);
        return result;
    }
}