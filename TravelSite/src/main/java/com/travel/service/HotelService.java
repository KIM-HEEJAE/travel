package com.travel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.HotelDTO;
import com.travel.mapper.HotelMapper;

@Service
public class HotelService {

    @Autowired
    private HotelMapper hotelMapper;

    public List<HotelDTO> getHotelList(Map<String, Object> params) {
        return hotelMapper.selectHotelList(params);
    }

    public HotelDTO getHotel(int hotelId) {
        return hotelMapper.selectHotelById(hotelId);
    }
}