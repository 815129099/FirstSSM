package com.smart.service;


import com.github.pagehelper.PageInfo;
import com.smart.bean.Book;

import java.util.List;

public interface bookService {
    public List<Book> getList();
    //查询书籍列表
    public PageInfo<Book> pageBook(Book book, Integer pageNum, Integer pageSize);
    //添加书籍
    public boolean addBook(Book book);
    //判断书籍代码是否已存在
    public boolean isIdExist(String bookId);
    //判断书籍名称是否已存在
    public boolean isNameExist(String bookName);
    //登记
    public boolean checkBook(String bookId);


}
