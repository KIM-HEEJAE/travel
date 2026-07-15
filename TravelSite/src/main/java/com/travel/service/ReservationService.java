package com.travel.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.FlightDTO;
import com.travel.dto.ReservationDTO;
import com.travel.mapper.ReservationMapper;

@Service
public class ReservationService {

	@Autowired
	private FlightService flightService;
    @Autowired
    private ReservationMapper reservationMapper;

    public void reserve(ReservationDTO reservation) {
        reservationMapper.insertReservation(reservation);
    }

    public List<ReservationDTO> getMyReservations(int memberId) {
        return reservationMapper.selectReservationsByMemberId(memberId);
    }

    public String cancelReservation(int reservationId, int memberId) {
        ReservationDTO reservation = reservationMapper.selectReservationById(reservationId);
        if(reservation ==null || reservation.getMemberId() != memberId) {
        	return "fail:notfound";
        }
        FlightDTO flight = flightService.getFlight(reservation.getFlightId());
        if(flight==null) {
        	return "fail:notfound";
        }
        long diff = flight.getFlightDate().getTime() - new Date().getTime();
        long hoursLeft = diff / (1000 * 60 * 80);
        if(hoursLeft <24 ) {
        	return "fail:toolate";
        }
        reservationMapper.deleteReservation(reservationId);
        return "success";
    }
}