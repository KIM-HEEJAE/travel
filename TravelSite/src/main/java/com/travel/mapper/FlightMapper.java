package com.travel.mapper;

import java.util.List;
import java.util.Map;

import com.travel.dto.FlightDTO;

public interface FlightMapper {

    List<FlightDTO> selectFlightList(Map<String, Object> params);

    FlightDTO selectFlightById(int flightId);
    
    List<FlightDTO> selectPopularFlights(int limit);

    
    // 관리자용 CRUD
    void insertFlight(FlightDTO flight);

    void updateFlight(FlightDTO flight);

    void deleteFlight(int flightId);
}