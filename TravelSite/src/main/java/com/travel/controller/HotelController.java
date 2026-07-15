package com.travel.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.travel.dto.HotelDTO;
import com.travel.dto.HotelReservationDTO;
import com.travel.dto.MemberDTO;
import com.travel.dto.ReviewDTO;
import com.travel.service.HotelReservationService;
import com.travel.service.HotelService;
import com.travel.service.ReviewService;

@Controller
@RequestMapping("/hotel")
public class HotelController {

    @Autowired
    private HotelService hotelService;

    @Autowired
    private HotelReservationService hotelReservationService;
    
    @Autowired 
    private ReviewService reviewService;

    // 숙소 검색/목록
    @RequestMapping("/list")
    public String list(
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "hotelType", required = false) String hotelType,
            Model model) {

        Map<String, Object> params = new HashMap<>();
        params.put("location", location);
        params.put("hotelType", hotelType);

        List<HotelDTO> hotelList = hotelService.getHotelList(params);

        model.addAttribute("hotelList", hotelList);
        model.addAttribute("location", location);
        model.addAttribute("hotelType", hotelType);

        return "hotel/list";
    }

    // 예약 폼
    @RequestMapping("/reserve")
    public String reserveForm(@RequestParam("hotelId") int hotelId, HttpSession session, Model model) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        HotelDTO hotel = hotelService.getHotel(hotelId);
        model.addAttribute("hotel", hotel);
        return "hotel/reserve";
    }

 // 예약 처리
    @RequestMapping("/reserveProc")
    public String reserveProc(@RequestParam("hotelId") int hotelId,
                               @RequestParam("checkIn") String checkInStr,
                               @RequestParam("checkOut") String checkOutStr,
                               @RequestParam("guestName") String guestName,
                               HttpSession session,
                               Model model) throws Exception {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date checkIn = sdf.parse(checkInStr);
        Date checkOut = sdf.parse(checkOutStr);

        // 숙박일수 계산 (밀리초 차이 → 일수로 변환)
        long diffMillis = checkOut.getTime() - checkIn.getTime();
        long nights = diffMillis / (1000 * 60 * 60 * 24);

        // 서버단 검증: 체크아웃이 체크인보다 늦어야 하고, 최소 1박 이상이어야 함
        if (nights < 1) {
            HotelDTO hotel = hotelService.getHotel(hotelId);
            model.addAttribute("hotel", hotel);
            model.addAttribute("error", "체크아웃 날짜는 체크인 날짜보다 최소 하루 이후여야 합니다.");
            return "hotel/reserve";
        }

        HotelDTO hotel = hotelService.getHotel(hotelId);
        int totalPrice = hotel.getPricePerNight() * (int) nights;

        HotelReservationDTO reservation = new HotelReservationDTO();
        reservation.setHotelId(hotelId);
        reservation.setMemberId(loginMember.getMemberId());
        reservation.setCheckIn(checkIn);
        reservation.setCheckOut(checkOut);
        reservation.setGuestName(guestName);
        reservation.setTotalPrice(totalPrice);

        hotelReservationService.reserve(reservation);

        return "redirect:/hotel/myReservations";
    }

    // 내 숙소 예약 목록
    @RequestMapping("/myReservations")
    public String myReservations(HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        List<HotelReservationDTO> myReservations = hotelReservationService.getMyReservations(loginMember.getMemberId());
        model.addAttribute("myReservations", myReservations);
        return "hotel/myReservations";
    }
    @RequestMapping("/detail")
    public String detail(@RequestParam("hotelId") int hotelId, Model model) {
        HotelDTO hotel = hotelService.getHotel(hotelId);

        double avgRating = reviewService.getAvgRating(hotelId);
        int reviewCount = reviewService.getReviewCount(hotelId);
        List<ReviewDTO> reviews = reviewService.getReviews(hotelId);

        model.addAttribute("hotel", hotel);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("reviewCount", reviewCount);
        model.addAttribute("reviews", reviews);

        return "hotel/detail";
    }
    // 예약 취소
    @RequestMapping("/cancel")
    public String cancel(@RequestParam("hotelResvId") int hotelResvId, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        String result = hotelReservationService.cancelReservation(hotelResvId, loginMember.getMemberId());
        if ("fail:toolate".equals(result)) {
            redirectAttributes.addFlashAttribute("error", "체크인 24시간 이내의 예약은 취소할 수 없습니다.");
        } else if ("fail:notfound".equals(result)) {
            redirectAttributes.addFlashAttribute("error", "취소할 수 없는 예약입니다.");
        }
        return "redirect:/hotel/myReservations";
    }
}