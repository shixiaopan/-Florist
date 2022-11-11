package com.code.shop.service.impl;


import com.code.shop.dao.AdminMapper;
import com.code.shop.entity.Admin;
import com.code.shop.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired(required = false)
    private AdminMapper adminMapper;

    @Override
    public Admin selectByName(Admin admin) {
        return adminMapper.selectByName(admin);
    }

    @Override
    public int updateByPrimaryKey(Admin admin) {
        return adminMapper.updateByPrimaryKeySelective(admin);
    }
}
