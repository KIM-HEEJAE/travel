package com.travel.mapper;

import org.apache.ibatis.annotations.Param;

public interface LikeMapper {

    void insertLike(@Param("boardId") int boardId, @Param("memberId") int memberId);

    void deleteLike(@Param("boardId") int boardId, @Param("memberId") int memberId);

    int countMyLike(@Param("boardId") int boardId, @Param("memberId") int memberId);

    int countLikes(int boardId);
}