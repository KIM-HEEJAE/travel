package com.travel.mapper;

import java.util.List;

import com.travel.dto.ReservationDTO;

public interface ReservationMapper {

    void insertReservation(ReservationDTO reservation);

    List<ReservationDTO> selectReservationsByMemberId(int memberId);

    void deleteReservation(int reservationId);

    ReservationDTO selectReservationById(int reservationId);
}