package com.travel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.ReviewDTO;
import com.travel.mapper.ReviewMapper;

@Service
public class ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;

    public void writeReview(ReviewDTO review) {
        reviewMapper.insertReview(review);
    }

    public List<ReviewDTO> getReviews(int hotelId) {
        return reviewMapper.selectReviewsByHotelId(hotelId);
    }

    public double getAvgRating(int hotelId) {
        Double avg = reviewMapper.selectAvgRating(hotelId);
        return avg != null ? avg : 0.0;
    }

    public int getReviewCount(int hotelId) {
        return reviewMapper.countReviews(hotelId);
    }

    public boolean hasReviewed(int hotelResvId) {
        return reviewMapper.countReviewByResvId(hotelResvId) > 0;
    }
}