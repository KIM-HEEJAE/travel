package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationDTO {
    private int reservationId;
    private int flightId;
    private int memberId;
    private String passengerName;
    private Date reserveDate;
    private String status;

    // 목록에서 항공편 정보도 같이 보여주기 위한 JOIN 필드
    private String airline;
    private String departure;
    private String arrival;
    private String departTime;
    private Date flightDate;
    private int price;
}