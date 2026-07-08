package com.travel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.CommentDTO;
import com.travel.mapper.CommentMapper;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    public List<CommentDTO> getComments(int boardId) {
        return commentMapper.selectCommentsByBoardId(boardId);
    }

    public void writeComment(CommentDTO comment) {
        commentMapper.insertComment(comment);
    }

    public void removeComment(int commentId, int memberId) {
        CommentDTO comment = commentMapper.selectCommentById(commentId);
        // 본인 댓글인지 확인 후 삭제 (권한 체크)
        if (comment != null && comment.getMemberId() == memberId) {
            commentMapper.deleteComment(commentId);
        }
    }

    public int getCommentCount(int boardId) {
        return commentMapper.countCommentsByBoardId(boardId);
    }
}