package com.travel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.BoardDTO;
import com.travel.mapper.BoardMapper;

@Service
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    public List<BoardDTO> getBoardList(Map<String, Object> params) {
        return boardMapper.selectBoardList(params);
    }

    public int getBoardCount(Map<String, Object> params) {
        return boardMapper.selectBoardCount(params);
    }

    public BoardDTO getBoardDetail(int boardId) {
        boardMapper.increaseViewCnt(boardId);
        return boardMapper.selectBoardById(boardId);
    }

    public void writeBoard(BoardDTO board) {
        boardMapper.insertBoard(board);
    }

    public void modifyBoard(BoardDTO board) {
        boardMapper.updateBoard(board);
    }

    public void removeBoard(int boardId) {
        boardMapper.deleteBoard(boardId);
    }
}