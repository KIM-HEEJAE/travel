package com.travel.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.travel.dto.HotelReservationDTO;
import com.travel.dto.MemberDTO;
import com.travel.dto.ReviewDTO;
import com.travel.service.HotelReservationService;
import com.travel.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private HotelReservationService hotelReservationService;

    @RequestMapping("/write")
    public String writeForm(@RequestParam("hotelResvId") int hotelResvId, HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        if (reviewService.hasReviewed(hotelResvId)) {
            return "redirect:/hotel/myReservations";
        }

        HotelReservationDTO resv = hotelReservationService.getReservation(hotelResvId); // 아래 8번에서 추가
        model.addAttribute("hotelResvId", hotelResvId);
        model.addAttribute("hotelId", resv.getHotelId());
        return "review/write";
    }

    // 리뷰 등록 처리
    @RequestMapping("/insert")
    public String insert(@RequestParam("hotelId") int hotelId,
                          @RequestParam("hotelResvId") int hotelResvId,
                          @RequestParam("rating") double rating,
                          @RequestParam("content") String content,
                          HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 본인 예약 건인지, 이미 리뷰 썼는지 서버단 재검증
        if (reviewService.hasReviewed(hotelResvId)) {
            return "redirect:/hotel/myReservations";
        }

        ReviewDTO review = new ReviewDTO();
        review.setHotelId(hotelId);
        review.setMemberId(loginMember.getMemberId());
        review.setHotelResvId(hotelResvId);
        review.setRating(rating);
        review.setContent(content);

        reviewService.writeReview(review);

        return "redirect:/hotel/detail?hotelId=" + hotelId;
    }
}