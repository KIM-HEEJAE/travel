package com.travel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.ReservationDTO;
import com.travel.mapper.ReservationMapper;

@Service
public class ReservationService {

    @Autowired
    private ReservationMapper reservationMapper;

    public void reserve(ReservationDTO reservation) {
        reservationMapper.insertReservation(reservation);
    }

    public List<ReservationDTO> getMyReservations(int memberId) {
        return reservationMapper.selectReservationsByMemberId(memberId);
    }

    public void cancelReservation(int reservationId, int memberId) {
        ReservationDTO reservation = reservationMapper.selectReservationById(reservationId);
        // 본인 예약인지 확인 후 삭제
        if (reservation != null && reservation.getMemberId() == memberId) {
            reservationMapper.deleteReservation(reservationId);
        }
    }
}