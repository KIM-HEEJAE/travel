package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
    private int reviewId;
    private int hotelId;
    private int memberId;
    private int hotelResvId;
    private double rating;
    private String content;
    private Date regDate;

    private String memberName;  // 작성자 표시용
}