package com.travel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.HotelReservationDTO;
import com.travel.mapper.HotelReservationMapper;

@Service
public class HotelReservationService {

    @Autowired
    private HotelReservationMapper hotelReservationMapper;

    public void reserve(HotelReservationDTO reservation) {
        hotelReservationMapper.insertHotelReservation(reservation);
    }

    public List<HotelReservationDTO> getMyReservations(int memberId) {
        return hotelReservationMapper.selectHotelReservationsByMemberId(memberId);
    }

    public void cancelReservation(int hotelResvId, int memberId) {
        HotelReservationDTO reservation = hotelReservationMapper.selectHotelReservationById(hotelResvId);
        if (reservation != null && reservation.getMemberId() == memberId) {
            hotelReservationMapper.deleteHotelReservation(hotelResvId);
        }
    }
    public HotelReservationDTO getReservation(int hotelResvId) {
        return hotelReservationMapper.selectHotelReservationById(hotelResvId);
    }
}