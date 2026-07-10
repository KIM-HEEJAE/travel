package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.travel.dto.BoardDTO;
import com.travel.dto.FlightDTO;
import com.travel.dto.HotelDTO;
import com.travel.service.BoardService;
import com.travel.service.FlightService;
import com.travel.service.HotelService;

@Controller
public class RootController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private FlightService flightService;

    @Autowired
    private HotelService hotelService;

    @RequestMapping("/")
    public String home(Model model) {
        // 최신 게시글 5개
        Map<String, Object> boardParams = new HashMap<>();
        boardParams.put("startRow", 1);
        boardParams.put("endRow", 5);
        List<BoardDTO> recentBoards = boardService.getBoardList(boardParams);
        model.addAttribute("recentBoards", recentBoards);

        List<FlightDTO> flights = flightService.getPopularFlights(4);
        model.addAttribute("promoFlights", flights);

        List<HotelDTO> hotels = hotelService.getTopRatedHotels(4);
        model.addAttribute("promoHotels", hotels);

        return "home";
    }
}