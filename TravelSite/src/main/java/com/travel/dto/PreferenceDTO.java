package com.travel.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PreferenceDTO {
    private int prefId;
    private int memberId;
    private String travelStyle;     // 자연/도심/휴양/액티비티
    private String budgetRange;     // 저예산/중간/고예산
    private String preferDomestic;  // 국내/해외
}