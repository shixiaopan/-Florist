package com.code.shop.dao;


import com.code.shop.entity.Favorite;
import com.code.shop.entity.FavoriteExample;
import com.code.shop.entity.FavoriteKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FavoriteMapper {
    long countByExample(FavoriteExample example);

    int deleteByExample(FavoriteExample example);

    int deleteByPrimaryKey(FavoriteKey key);

    int insert(Favorite record);

    int insertSelective(Favorite record);

    List<Favorite> selectByExample(FavoriteExample example);

    Favorite selectByPrimaryKey(FavoriteKey key);

    int updateByExampleSelective(@Param("record") Favorite record, @Param("example") FavoriteExample example);

    int updateByExample(@Param("record") Favorite record, @Param("example") FavoriteExample example);

    int updateByPrimaryKeySelective(Favorite record);

    int updateByPrimaryKey(Favorite record);

    List<FavoriteKey> selectByUserId(@Param("userid") Integer userid);
}
