package com.travel.mapper;

import java.util.List;
import java.util.Map;

import com.travel.dto.HotelDTO;

public interface HotelMapper {

    List<HotelDTO> selectHotelList(Map<String, Object> params);

    HotelDTO selectHotelById(int hotelId);
}