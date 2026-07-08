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

import com.travel.dto.BoardDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.BoardService;

import page.PageUtil;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // 게시글 목록
    @RequestMapping("/list")
    public String list(
            @RequestParam(value = "curPage", defaultValue = "1") int curPage,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        // 검색/필터 조건 담을 Map
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("keyword", keyword);

        // 전체 게시글 수 조회 (페이징 계산을 위해 먼저 필요)
        int totalCount = boardService.getBoardCount(params);

        // PageUtil로 페이징 계산
        PageUtil pageUtil = new PageUtil(totalCount, curPage);

        // 계산된 시작/끝 행 번호를 params에 추가
        params.put("startRow", pageUtil.getPageBegin());
        params.put("endRow", pageUtil.getPageEnd());

        // 게시글 목록 조회
        List<BoardDTO> boardList = boardService.getBoardList(params);

        model.addAttribute("boardList", boardList);
        model.addAttribute("pageUtil", pageUtil);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);

        return "board/list";
    }

    // 게시글 상세
    @RequestMapping("/detail")
    public String detail(@RequestParam("boardId") int boardId, Model model) {
        BoardDTO board = boardService.getBoardDetail(boardId);
        model.addAttribute("board", board);
        return "board/detail";
    }

    // 게시글 작성 폼
    @RequestMapping("/write")
    public String writeForm(HttpSession session) {
    	if(session.getAttribute("loginMember")==null) {
    		return "redirect:/member/login";
    	}
        return "board/write";
    }

    // 게시글 등록 처리
    @RequestMapping("/insert")
    public String insert(BoardDTO board, HttpSession session) {
    	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
    	if(loginMember ==null) {
    		return "redirect:/member/login";
    	}
    	board.setMemberId(loginMember.getMemberId());
        boardService.writeBoard(board);
        return "redirect:/board/list";
    }

    // 게시글 수정 폼
    @RequestMapping("/modify")
    public String modifyForm(@RequestParam("boardId") int boardId, Model model) {
        BoardDTO board = boardService.getBoardDetail(boardId);
        model.addAttribute("board", board);
        return "board/modify";
    }

    // 게시글 수정 처리
    @RequestMapping("/update")
    public String update(BoardDTO board) {
        boardService.modifyBoard(board);
        return "redirect:/board/detail?boardId=" + board.getBoardId();
    }

    // 게시글 삭제
    @RequestMapping("/delete")
    public String delete(@RequestParam("boardId") int boardId) {
        boardService.removeBoard(boardId);
        return "redirect:/board/list";
    }
}