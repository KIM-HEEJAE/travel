package com.travel.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.travel.dto.BoardDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.BoardService;
import page.PageUtil;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Value("${upload.path}")
    private String uploadPath;

    // 게시글 목록
    @RequestMapping("/list")
    public String list(
            @RequestParam(value = "curPage", defaultValue = "1") int curPage,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("keyword", keyword);

        int totalCount = boardService.getBoardCount(params);
        PageUtil pageUtil = new PageUtil(totalCount, curPage);

        params.put("startRow", pageUtil.getPageBegin());
        params.put("endRow", pageUtil.getPageEnd());

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
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        return "board/write";
    }

    // 게시글 등록 처리 (이미지 업로드 포함)
    @RequestMapping("/insert")
    public String insert(BoardDTO board,
                          @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                          HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        board.setMemberId(loginMember.getMemberId());

        // 이미지 파일이 있으면 저장
        if (imageFile != null && !imageFile.isEmpty()) {
            String savedFileName = saveImage(imageFile);
            board.setImagePath(savedFileName);
        }

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

    // 게시글 수정 처리 (이미지 재업로드 포함)
    @RequestMapping("/update")
    public String update(BoardDTO board,
                          @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        if (imageFile != null && !imageFile.isEmpty()) {
            String savedFileName = saveImage(imageFile);
            board.setImagePath(savedFileName);
        } else {
            board.setImagePath(null); // 새 이미지 없으면 기존 이미지 유지 (XML의 <if>가 처리)
        }
        boardService.modifyBoard(board);
        return "redirect:/board/detail?boardId=" + board.getBoardId();
    }

    // 게시글 삭제
    @RequestMapping("/delete")
    public String delete(@RequestParam("boardId") int boardId) {
        boardService.removeBoard(boardId);
        return "redirect:/board/list";
    }

    // 이미지 파일 저장 로직 (중복 방지 위해 UUID로 이름 변경)
    private String saveImage(MultipartFile file) {
        try {
            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String originalName = file.getOriginalFilename();
            String ext = originalName.substring(originalName.lastIndexOf("."));
            String savedName = UUID.randomUUID().toString() + ext;

            File dest = new File(uploadPath + savedName);
            try (FileOutputStream fos = new FileOutputStream(dest)) {
                fos.write(file.getBytes());
            }

            return savedName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}