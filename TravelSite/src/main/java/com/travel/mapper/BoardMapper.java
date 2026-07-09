package com.travel.mapper;

import java.util.List;
import java.util.Map;

import com.travel.dto.BoardDTO;

public interface BoardMapper {

	List<BoardDTO> selectBoardList(Map<String, Object> params);

	int selectBoardCount(Map<String, Object> params);

	void increaseViewCnt(int boardId);

	BoardDTO selectBoardById(int boardId);

	void insertBoard(BoardDTO board);

	void updateBoard(BoardDTO board);

	void deleteBoard(int boardId);

	List<BoardDTO> selectBoardsByMemberId(int memberId);

}
