package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HotelReservationDTO {
    private int hotelResvId;
    private int hotelId;
    private int memberId;
    private Date checkIn;
    private Date checkOut;
    private String guestName;
    private Date reserveDate;
    private String status;
    private int totalPrice;
    // 목록 표시용 JOIN 필드
    private String hotelName;
    private String location;
    private int pricePerNight;
}