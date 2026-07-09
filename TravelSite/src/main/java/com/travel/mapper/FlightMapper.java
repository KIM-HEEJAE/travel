package com.travel.mapper;

import java.util.List;
import java.util.Map;

import com.travel.dto.FlightDTO;

public interface FlightMapper {

    List<FlightDTO> selectFlightList(Map<String, Object> params);

    FlightDTO selectFlightById(int flightId);
}