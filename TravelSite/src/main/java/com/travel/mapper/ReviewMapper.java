package com.travel.mapper;

import java.util.List;

import com.travel.dto.ReviewDTO;

public interface ReviewMapper {

    void insertReview(ReviewDTO review);

    List<ReviewDTO> selectReviewsByHotelId(int hotelId);

    Double selectAvgRating(int hotelId);

    int countReviews(int hotelId);

    // 이미 리뷰 쓴 예약인지 확인
    int countReviewByResvId(int hotelResvId);
}