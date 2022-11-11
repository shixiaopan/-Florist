package com.code.shop.service;


import com.code.shop.entity.Comment;
import com.code.shop.entity.CommentExample;

import java.util.List;

public interface CommentService {
    public void insertSelective(Comment comment);

    public List<Comment> selectByExample(CommentExample commentExample);
}
