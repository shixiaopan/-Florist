package com.code.shop.service;


import com.code.shop.entity.User;
import com.code.shop.entity.UserExample;

import java.util.List;

public interface UserService {
    public User selectByPrimaryKey(int userId);
    /*public User selectByPrimaryKeyAndPassword(int userId,String password);*/
    public List<User> selectByExample(UserExample userExample);

    public void insertSelective(User user);

    public void deleteUserById(Integer userid);

    public void updateByPrimaryKeySelective(User user);

}
