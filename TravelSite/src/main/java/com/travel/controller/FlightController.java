package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.travel.dto.FlightDTO;
import com.travel.dto.MemberDTO;
import com.travel.dto.ReservationDTO;
import com.travel.service.FlightService;
import com.travel.service.ReservationService;

@Controller
@RequestMapping("/flight")
public class FlightController {

    @Autowired
    private FlightService flightService;

    @Autowired
    private ReservationService reservationService;

    // 항공권 검색/목록
    @RequestMapping("/list")
    public String list(
            @RequestParam(value = "flightType", required = false) String flightType,
            @RequestParam(value = "departure", required = false) String departure,
            @RequestParam(value = "arrival", required = false) String arrival,
            Model model) {

        Map<String, Object> params = new HashMap<>();
        params.put("flightType", flightType);
        params.put("departure", departure);
        params.put("arrival", arrival);

        List<FlightDTO> flightList = flightService.getFlightList(params);

        model.addAttribute("flightList", flightList);
        model.addAttribute("flightType", flightType);
        model.addAttribute("departure", departure);
        model.addAttribute("arrival", arrival);

        return "flight/list";
    }

    // 예약 폼
    @RequestMapping("/reserve")
    public String reserveForm(@RequestParam("flightId") int flightId, HttpSession session, Model model) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        FlightDTO flight = flightService.getFlight(flightId);
        model.addAttribute("flight", flight);
        return "flight/reserve";
    }

    // 예약 처리
    @RequestMapping("/reserveProc")
    public String reserveProc(@RequestParam("flightId") int flightId,
                               @RequestParam("passengerName") String passengerName,
                               HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        ReservationDTO reservation = new ReservationDTO();
        reservation.setFlightId(flightId);
        reservation.setMemberId(loginMember.getMemberId());
        reservation.setPassengerName(passengerName);

        reservationService.reserve(reservation);

        return "redirect:/flight/myReservations";
    }

    // 내 예약 목록
    @RequestMapping("/myReservations")
    public String myReservations(HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        List<ReservationDTO> myReservations = reservationService.getMyReservations(loginMember.getMemberId());
        model.addAttribute("myReservations", myReservations);
        return "flight/myReservations";
    }

    // 예약 취소
    @RequestMapping("/cancel")
    public String cancel(@RequestParam("reservationId") int reservationId, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        reservationService.cancelReservation(reservationId, loginMember.getMemberId());
        return "redirect:/flight/myReservations";
    }
}