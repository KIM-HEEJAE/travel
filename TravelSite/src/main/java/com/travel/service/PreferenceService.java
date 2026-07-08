package com.travel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dto.PreferenceDTO;
import com.travel.mapper.PreferenceMapper;

@Service
public class PreferenceService {

    @Autowired
    private PreferenceMapper preferenceMapper;

    public void savePreference(PreferenceDTO pref) {
        preferenceMapper.insertPreference(pref);
    }

    public PreferenceDTO getPreference(int memberId) {
        return preferenceMapper.selectPreferenceByMemberId(memberId);
    }

    public boolean hasPreference(int memberId) {
        return preferenceMapper.selectPreferenceByMemberId(memberId) != null;
    }

    public List<Map<String, Object>> getStyleStats() {
        return preferenceMapper.selectStyleStats();
    }

    public List<Map<String, Object>> getBudgetStats() {
        return preferenceMapper.selectBudgetStats();
    }

    public List<Map<String, Object>> getDomesticStats() {
        return preferenceMapper.selectDomesticStats();
    }

    public List<Map<String, Object>> getPopularRegions() {
        return preferenceMapper.selectPopularRegions();
    }
}