package com.travel.mapper;

import java.util.List;

import com.travel.dto.HotelReservationDTO;

public interface HotelReservationMapper {

    void insertHotelReservation(HotelReservationDTO reservation);

    List<HotelReservationDTO> selectHotelReservationsByMemberId(int memberId);

    void deleteHotelReservation(int hotelResvId);

    HotelReservationDTO selectHotelReservationById(int hotelResvId);
}