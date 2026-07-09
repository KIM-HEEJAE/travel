package com.travel.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.mapper.LikeMapper;

@Service
public class LikeService {

    @Autowired
    private LikeMapper likeMapper;

    // 좋아요 토글 (눌려있으면 취소, 안 눌려있으면 추가) 후 결과 반환
    public Map<String, Object> toggleLike(int boardId, int memberId) {
        boolean alreadyLiked = likeMapper.countMyLike(boardId, memberId) > 0;

        if (alreadyLiked) {
            likeMapper.deleteLike(boardId, memberId);
        } else {
            likeMapper.insertLike(boardId, memberId);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("liked", !alreadyLiked);
        result.put("likeCount", likeMapper.countLikes(boardId));
        return result;
    }

    public int getLikeCount(int boardId) {
        return likeMapper.countLikes(boardId);
    }

    public boolean isLikedByMe(int boardId, int memberId) {
        return likeMapper.countMyLike(boardId, memberId) > 0;
    }
}