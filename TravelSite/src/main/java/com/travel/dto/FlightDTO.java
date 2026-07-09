package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FlightDTO {
    private int flightId;
    private String airline;
    private String departure;
    private String arrival;
    private String flightType;   // 국내선/국제선
    private String departTime;
    private String arriveTime;
    private String duration;
    private int price;
    private String seatClass;
    private Date flightDate;
}