package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class BoardDTO {
    private int boardId;
    private int memberId;
    private String title;
    private String content;
    private String region;
    private String category;
    private int viewCnt;
    private Date regDate;
    
    // 게시글 작성자 이름 (JOIN해서 가져올 때 사용)
    private String memberName;
}
