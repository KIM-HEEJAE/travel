package com.travel.service;

import java.util.Date;
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

    public String cancelReservation(int hotelResvId, int memberId) {
        HotelReservationDTO reservation = hotelReservationMapper.selectHotelReservationById(hotelResvId);
        if (reservation == null || reservation.getMemberId() != memberId) {
        	return "fail:notfound";
        }
        long diff = reservation.getCheckIn().getTime() - new Date().getTime();
        long hoursLeft = diff / (1000 * 60 * 60);

        if (hoursLeft < 24) {
            return "fail:toolate";
        }

        hotelReservationMapper.deleteHotelReservation(hotelResvId);
        return "success";
    }
    public HotelReservationDTO getReservation(int hotelResvId) {
        return hotelReservationMapper.selectHotelReservationById(hotelResvId);
    }
}