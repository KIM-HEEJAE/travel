package com.travel.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HotelDTO {
    private int hotelId;
    private String hotelName;
    private String location;
    private String hotelType;
    private int pricePerNight;
    private double rating;
    private String description;
    private String imagePath;
}