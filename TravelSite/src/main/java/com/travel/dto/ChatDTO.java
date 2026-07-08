package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatDTO {
    private int chatId;
    private int memberId;
    private String question;
    private String answer;
    private Date regDate;
}