package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.travel.dto.BoardDTO;
import com.travel.service.BoardService;

@Controller
public class RootController {

    @Autowired
    private BoardService boardService;

    @RequestMapping("/")
    public String home(Model model) {
        // 최신 게시글 5개만 미리보기로 가져오기
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", 1);
        params.put("endRow", 5);

        List<BoardDTO> recentBoards = boardService.getBoardList(params);
        model.addAttribute("recentBoards", recentBoards);

        return "home";
    }
}