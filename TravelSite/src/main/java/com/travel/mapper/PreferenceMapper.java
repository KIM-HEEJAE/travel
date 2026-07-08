package com.travel.mapper;

import java.util.List;
import java.util.Map;

import com.travel.dto.PreferenceDTO;

public interface PreferenceMapper {

    // 취향 등록
    void insertPreference(PreferenceDTO pref);

    // 특정 회원의 취향 조회
    PreferenceDTO selectPreferenceByMemberId(int memberId);

    // 취향 스타일별 통계 (원형 그래프용) - [{name: '자연', count: 12}, ...]
    List<Map<String, Object>> selectStyleStats();

    // 예산대별 통계 (막대 그래프용)
    List<Map<String, Object>> selectBudgetStats();

    // 국내/해외 선호 통계
    List<Map<String, Object>> selectDomesticStats();

    // 게시판 지역별 인기 여행지 TOP5 (막대 그래프용)
    List<Map<String, Object>> selectPopularRegions();
}