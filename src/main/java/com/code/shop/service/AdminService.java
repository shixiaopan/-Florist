package com.code.shop.service;


import com.code.shop.entity.Admin;

public interface AdminService {
    public Admin selectByName(Admin admin);

    int updateByPrimaryKey(Admin admin);
}
