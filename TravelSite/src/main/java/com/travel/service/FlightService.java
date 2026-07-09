package com.travel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.FlightDTO;
import com.travel.mapper.FlightMapper;

@Service
public class FlightService {

    @Autowired
    private FlightMapper flightMapper;

    public List<FlightDTO> getFlightList(Map<String, Object> params) {
        return flightMapper.selectFlightList(params);
    }

    public FlightDTO getFlight(int flightId) {
        return flightMapper.selectFlightById(flightId);
    }
}