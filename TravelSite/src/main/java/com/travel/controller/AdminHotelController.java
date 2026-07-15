package com.travel.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.travel.dto.HotelDTO;
import com.travel.dto.MemberDTO;
import com.travel.service.HotelService;

@Controller
@RequestMapping("/admin/hotel")
public class AdminHotelController {

    @Autowired
    private HotelService hotelService;

    private boolean isAdmin(HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        return loginMember != null && "Y".equals(loginMember.getIsAdmin());
    }

    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        List<HotelDTO> hotelList = hotelService.getHotelList(new HashMap<>());
        model.addAttribute("hotelList", hotelList);
        return "admin/hotel/list";
    }

    @RequestMapping("/write")
    public String writeForm(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        return "admin/hotel/write";
    }

    @RequestMapping("/insert")
    public String insert(@RequestParam("hotelName") String hotelName,
                          @RequestParam("location") String location,
                          @RequestParam("hotelType") String hotelType,
                          @RequestParam("pricePerNight") int pricePerNight,
                          @RequestParam(value = "rating", defaultValue = "4.0") double rating,
                          @RequestParam("description") String description,
                          HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        HotelDTO hotel = new HotelDTO();
        hotel.setHotelName(hotelName);
        hotel.setLocation(location);
        hotel.setHotelType(hotelType);
        hotel.setPricePerNight(pricePerNight);
        hotel.setRating(rating);
        hotel.setDescription(description);

        hotelService.addHotel(hotel);

        return "redirect:/admin/hotel/list";
    }

    @RequestMapping("/modify")
    public String modifyForm(@RequestParam("hotelId") int hotelId, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        HotelDTO hotel = hotelService.getHotel(hotelId);
        model.addAttribute("hotel", hotel);
        return "admin/hotel/modify";
    }

    @RequestMapping("/update")
    public String update(@RequestParam("hotelId") int hotelId,
                          @RequestParam("hotelName") String hotelName,
                          @RequestParam("location") String location,
                          @RequestParam("hotelType") String hotelType,
                          @RequestParam("pricePerNight") int pricePerNight,
                          @RequestParam("description") String description,
                          HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        HotelDTO hotel = new HotelDTO();
        hotel.setHotelId(hotelId);
        hotel.setHotelName(hotelName);
        hotel.setLocation(location);
        hotel.setHotelType(hotelType);
        hotel.setPricePerNight(pricePerNight);
        hotel.setDescription(description);

        hotelService.editHotel(hotel);

        return "redirect:/admin/hotel/list";
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam("hotelId") int hotelId, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        hotelService.removeHotel(hotelId);
        return "redirect:/admin/hotel/list";
    }
}