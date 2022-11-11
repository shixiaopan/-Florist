package com.code.shop.service;


import com.code.shop.entity.ShopCart;
import com.code.shop.entity.ShopCartExample;
import com.code.shop.entity.ShopCartKey;

import java.util.List;

public interface ShopCartService {
    public void addShopCart(ShopCart shopCart);

    public List<ShopCart> selectByExample(ShopCartExample shopCartExample);

    public void deleteByKey(ShopCartKey shopCartKey);

    public void updateCartByKey(ShopCart shopCart);

    public ShopCart selectCartByKey(ShopCartKey shopCartKey);
}
