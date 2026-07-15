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

import com.travel.dto.FlightDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.FlightService;

@Controller
@RequestMapping("/admin/flight")
public class AdminFlightController {

    @Autowired
    private FlightService flightService;

    private boolean isAdmin(HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        return loginMember != null && "Y".equals(loginMember.getIsAdmin());
    }

    // 항공권 관리 목록
    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        List<FlightDTO> flightList = flightService.getFlightList(new HashMap<>());
        model.addAttribute("flightList", flightList);
        return "admin/flight/list";
    }

    // 등록 폼
    @RequestMapping("/write")
    public String writeForm(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        return "admin/flight/write";
    }

    // 등록 처리
    @RequestMapping("/insert")
    public String insert(@RequestParam("airline") String airline,
                          @RequestParam("departure") String departure,
                          @RequestParam("arrival") String arrival,
                          @RequestParam("flightType") String flightType,
                          @RequestParam("departTime") String departTime,
                          @RequestParam("arriveTime") String arriveTime,
                          @RequestParam("duration") String duration,
                          @RequestParam("price") int price,
                          @RequestParam("seatClass") String seatClass,
                          @RequestParam("flightDate") String flightDateStr,
                          HttpSession session) throws Exception {
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        FlightDTO flight = new FlightDTO();
        flight.setAirline(airline);
        flight.setDeparture(departure);
        flight.setArrival(arrival);
        flight.setFlightType(flightType);
        flight.setDepartTime(departTime);
        flight.setArriveTime(arriveTime);
        flight.setDuration(duration);
        flight.setPrice(price);
        flight.setSeatClass(seatClass);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date flightDate = sdf.parse(flightDateStr);
        flight.setFlightDate(flightDate);

        flightService.addFlight(flight);

        return "redirect:/admin/flight/list";
    }

    // 수정 폼
    @RequestMapping("/modify")
    public String modifyForm(@RequestParam("flightId") int flightId, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        FlightDTO flight = flightService.getFlight(flightId);
        model.addAttribute("flight", flight);
        return "admin/flight/modify";
    }

    // 수정 처리
    @RequestMapping("/update")
    public String update(@RequestParam("flightId") int flightId,
                          @RequestParam("airline") String airline,
                          @RequestParam("departure") String departure,
                          @RequestParam("arrival") String arrival,
                          @RequestParam("flightType") String flightType,
                          @RequestParam("departTime") String departTime,
                          @RequestParam("arriveTime") String arriveTime,
                          @RequestParam("duration") String duration,
                          @RequestParam("price") int price,
                          @RequestParam("seatClass") String seatClass,
                          @RequestParam("flightDate") String flightDateStr,
                          HttpSession session) throws Exception {
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        FlightDTO flight = new FlightDTO();
        flight.setFlightId(flightId);
        flight.setAirline(airline);
        flight.setDeparture(departure);
        flight.setArrival(arrival);
        flight.setFlightType(flightType);
        flight.setDepartTime(departTime);
        flight.setArriveTime(arriveTime);
        flight.setDuration(duration);
        flight.setPrice(price);
        flight.setSeatClass(seatClass);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date flightDate = sdf.parse(flightDateStr);
        flight.setFlightDate(flightDate);

        flightService.editFlight(flight);

        return "redirect:/admin/flight/list";
    }

    // 삭제
    @RequestMapping("/delete")
    public String delete(@RequestParam("flightId") int flightId, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        flightService.removeFlight(flightId);
        return "redirect:/admin/flight/list";
    }
}