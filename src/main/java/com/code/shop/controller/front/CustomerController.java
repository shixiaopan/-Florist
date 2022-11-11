package com.code.shop.controller.front;


import com.code.shop.entity.*;
import com.code.shop.service.AddressService;
import com.code.shop.service.OrderService;
import com.code.shop.util.Md5Util;
import com.code.shop.util.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.code.shop.service.GoodsService;
import com.code.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CustomerController {
    @Autowired
    private UserService userService;
    @RequestMapping("/changepassword")
    public String changePasswordView() {
        return "changePassword";
    }

    @RequestMapping("/changepasswordresult")
    public String changepasswordResult(User user, Model loginResult,String confirmPassword) {
        System.out.println("传进来的用户帐号和密码为:" + user);
        UserExample userExample = new UserExample();
        userExample.or().andUsernameEqualTo(user.getUsername());
        List<User> userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            User user1 = userList.get(0);
            user1.setPassword(Md5Util.MD5Encode(user.getPassword(), "UTF-8"));
            userService.updateByPrimaryKeySelective(user1);
            loginResult.addAttribute("errorMsg", "修改密码成功");
            return "changePassword";
        } else {
            loginResult.addAttribute("errorMsg", "查无用户名");
            return "changePassword";
        }
    }

    @RequestMapping("/login")
    public String loginView() {
        return "login";
    }



    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/registerresult")
    public String registerResult(User user, Model registerResult) {
        List<User> userList = new ArrayList<>();
        user.setPassword(Md5Util.MD5Encode(user.getPassword(), "utf-8"));
        UserExample userExample = new UserExample();
        userExample.or().andUsernameLike(user.getUsername());
        userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            registerResult.addAttribute("errorMsg", "用户名被占用");
            return "register";
        } else {
            Date RegTime = new Date();
            user.setRegtime(RegTime);
            userService.insertSelective(user);
            return "redirect:/login";
        }
    }


    @RequestMapping("/loginconfirm")
    public String loginConfirm(User user, Model loginResult, HttpServletRequest request, @RequestParam("confirmlogo") String confirmlogo) {
        System.out.println("传进来的用户帐号和密码为:" + user);
        //进行用户密码MD5加密验证
        user.setPassword(Md5Util.MD5Encode(user.getPassword(), "UTF-8"));
        HttpSession session = request.getSession();
        String verificationCode = (String) session.getAttribute("certCode");
        if (!confirmlogo.equals(verificationCode)) {
            loginResult.addAttribute("errorMsg", "验证码错误");
            return "login";

        }
        UserExample userExample = new UserExample();
        userExample.or().andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
        List<User> userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            session.setAttribute("user", userList.get(0));
            return "redirect:/main";
        } else {
            loginResult.addAttribute("errorMsg", "用户名与密码不匹配");
            return "login";
        }
    }

    @RequestMapping("/information")
    public String information(Model userModel, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user;
        Integer userId;
        user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        userId = user.getUserid();
        user = userService.selectByPrimaryKey(userId);
        userModel.addAttribute("user", user);
        return "information";
    }

    @RequestMapping("/saveInfo")
    @ResponseBody
    public Msg saveInfo(String name, String email, String telephone, HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserExample userExample = new UserExample();
        User user, updateUser = new User();
        List<User> userList = new ArrayList<>();
        Integer userid;
        user = (User) session.getAttribute("user");
        userid = user.getUserid();
        userExample.or().andUsernameEqualTo(name);
        userExample.or().andEmailEqualTo(email);
        userExample.or().andTelephoneEqualTo(telephone);
        userList = userService.selectByExample(userExample);
        if (userList.isEmpty()) {
            updateUser.setUserid(userid);
            updateUser.setUsername(name);
            updateUser.setEmail(email);
            updateUser.setTelephone(telephone);
            userService.updateByPrimaryKeySelective(updateUser);
            return Msg.success("更新成功");
        } else {
            return Msg.fail("更新失败");
        }
    }

    @Autowired
    private AddressService addressService;

    @RequestMapping("/info/address")
    public String address(HttpServletRequest request, Model addressModel) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        AddressExample addressExample = new AddressExample();
        addressExample.or().andUseridEqualTo(user.getUserid());
        List<Address> addressList = addressService.getAllAddressByExample(addressExample);
        addressModel.addAttribute("addressList", addressList);
        return "address";
    }

    @RequestMapping("/saveAddr")
    @ResponseBody
    public Msg saveAddr(Address address) {

        addressService.updateByPrimaryKeySelective(address);
        return Msg.success("修改成功");
    }

    @RequestMapping("/deleteAddr")
    @ResponseBody
    public Msg deleteAddr(Address address) {
        addressService.deleteByPrimaryKey(address.getAddressid());
        return Msg.success("删除成功");
    }

    @RequestMapping("/insertAddr")
    @ResponseBody
    public Msg insertAddr(Address address, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = new User();
        user = (User) session.getAttribute("user");
        address.setUserid(user.getUserid());
        addressService.insertSelective(address);
        return Msg.success("添加成功");
    }

    @Autowired
    private OrderService orderService;

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("/info/list")
    public String list(HttpServletRequest request, Model orderModel) {

        HttpSession session = request.getSession();
        User user;
        user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }
        OrderExample orderExample = new OrderExample();
        orderExample.or().andUseridEqualTo(user.getUserid());
        List<Order> orderList = orderService.selectOrderByExample(orderExample);
        //查询该订单中的商品
        for (int i = 0; i < orderList.size(); i++) {
            //获取订单项中的goodsid
            Order order = orderList.get(i);
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.or().andOrderidEqualTo(order.getOrderid());
            List<OrderItem> orderItemList = orderService.getOrderItemByExample(orderItemExample);
            List<Integer> goodsIdList = new ArrayList<>();

            List<Goods> goodsList = new ArrayList<>();
            for (OrderItem orderItem : orderItemList) {
//                goodsIdList.add(orderItem.getGoodsid());
                Goods goods = goodsService.selectById(orderItem.getGoodsid());
                goods.setNum(orderItem.getNum());
                goodsList.add(goods);
            }

            //根据goodsid查询商品
            /*GoodsExample goodsExample = new GoodsExample();
            goodsExample.or().andGoodsidIn(goodsIdList);
            List<Goods> goodsList = goodsService.selectByExample(goodsExample);*/
            order.setGoodsInfo(goodsList);

            //查询地址
            Address address = orderService.getAddressByKey(order.getAddressid());
            order.setAddress(address);

            orderList.set(i, order);
        }
        orderModel.addAttribute("orderList", orderList);

        return "list";
    }


    @RequestMapping("/deleteList")
    @ResponseBody
    public Msg deleteList(Order order) {
        orderService.deleteById(order.getOrderid());
        return Msg.success("删除成功");
    }

    /**
     * 收藏商品
     * @param page
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/info/favorite")
    public String showFavorite( @RequestParam(value = "page", defaultValue = "1") Integer page, HttpServletRequest request, Model model,HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        //开始分页
        PageHelper.startPage(page, 3);
        List<FavoriteKey> favoriteKeyList = goodsService.selectFavByUserId(user.getUserid());
        //显示几个页号
        PageInfo pageInfo = new PageInfo(favoriteKeyList, 3);

        List<Goods> goodsList = new ArrayList<>();
        for (FavoriteKey favoritekey:favoriteKeyList
        ) {
            Goods goods = goodsService.selectById(favoritekey.getGoodsid());
            goodsList.add(goods);
        }

        //获取图片地址
        for (int i = 0; i < goodsList.size(); i++) {
            Goods goods = goodsList.get(i);
            List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
            goods.setImagePaths(imagePathList);
            //判断是否收藏
            goods.setFav(true);
            goodsList.set(i, goods);
        }
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("goodsList",goodsList);
        return "favorite";

    }

    @RequestMapping("/savePsw")
    @ResponseBody
    public Msg savePsw(String Psw, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (Psw.length()<6){
            return Msg.fail("密码格式错误");
        }
        user.setPassword(Md5Util.MD5Encode(Psw, "UTF-8"));
        userService.updateByPrimaryKeySelective(user);
        return Msg.success("修改密码成功");
    }

    @RequestMapping("/finishList")
    @ResponseBody
    public Msg finishiList(Integer orderid) {
        Order order = orderService.selectByPrimaryKey(orderid);
        order.setIsreceive(true);
        order.setIscomplete(true);
        orderService.updateOrderByKey(order);
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.or().andOrderidEqualTo(Integer.valueOf(orderid));
        orderService.getOrderItemByExample(orderItemExample);
//        orderService.insertSales()
        return Msg.success("完成订单成功");
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        return "redirect:/login";
    }

}
