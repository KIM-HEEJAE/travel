package com.travel.mapper;

import java.util.List;

import com.travel.dto.ChatDTO;

public interface ChatMapper {

    void insertChatLog(ChatDTO chat);

    List<ChatDTO> selectChatsByMemberId(int memberId);
}