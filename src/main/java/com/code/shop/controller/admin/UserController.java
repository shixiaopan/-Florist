package com.code.shop.controller.admin;

import com.code.shop.entity.Admin;
import com.code.shop.entity.User;
import com.code.shop.entity.UserExample;
import com.code.shop.util.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import com.code.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/showjson")
    @ResponseBody
    public Msg getAllGoods(@RequestParam(value = "page",defaultValue = "1") Integer pn, HttpServletResponse response, Model model) {
        //一页显示几个数据
        PageHelper.startPage(pn, 10);
        List<User> userList = userService.selectByExample(new UserExample());
        //显示几个页号
        PageInfo page = new PageInfo(userList,5);

       /* model.addAttribute("pageInfo", page);*/

        return Msg.success("查询成功!").add("pageInfo", page);
    }

    @RequestMapping("/show")
    public String userManage(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        return "userManage";
    }

    @RequestMapping(value = "/delete/{userid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteUser(@PathVariable("userid")Integer userid) {
//        goodsService.deleteGoodsById(goodsid);
        userService.deleteUserById(userid);
        return Msg.success("删除成功!");
    }
}
