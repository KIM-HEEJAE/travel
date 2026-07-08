package com.travel.mapper;

import java.util.List;

import com.travel.dto.CommentDTO;

public interface CommentMapper {

    // 특정 게시글의 댓글 목록
    List<CommentDTO> selectCommentsByBoardId(int boardId);

    // 댓글 등록
    void insertComment(CommentDTO comment);

    // 댓글 삭제
    void deleteComment(int commentId);

    // 댓글 작성자 확인용 (본인 댓글인지 체크)
    CommentDTO selectCommentById(int commentId);

    // 특정 게시글의 댓글 개수
    int countCommentsByBoardId(int boardId);
}