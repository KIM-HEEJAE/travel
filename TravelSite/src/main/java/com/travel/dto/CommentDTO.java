package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentDTO {
    private int commentId;
    private int boardId;
    private int memberId;
    private String content;
    private Date regDate;

    // 작성자 이름 (JOIN해서 가져올 때 사용)
    private String memberName;
}