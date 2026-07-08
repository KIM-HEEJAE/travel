package com.travel.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.CommentDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.CommentService;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 특정 게시글의 댓글 목록 (Ajax, JSON 반환)
    @RequestMapping("/list")
    @ResponseBody
    public List<CommentDTO> list(@RequestParam("boardId") int boardId) {
        return commentService.getComments(boardId);
    }

    // 댓글 등록 (Ajax)
    @RequestMapping("/write")
    @ResponseBody
    public String write(@RequestParam("boardId") int boardId,
                         @RequestParam("content") String content,
                         HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "fail:login";
        }
        CommentDTO comment = new CommentDTO();
        comment.setBoardId(boardId);
        comment.setMemberId(loginMember.getMemberId());
        comment.setContent(content);
        commentService.writeComment(comment);
        return "success";
    }

    // 댓글 삭제 (Ajax)
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("commentId") int commentId, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "fail:login";
        }
        commentService.removeComment(commentId, loginMember.getMemberId());
        return "success";
    }
}