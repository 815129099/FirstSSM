package com.smart.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smart.bean.Book;
import com.smart.dao.bookDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class bookServiceImp implements bookService {
    @Autowired
    bookDao bookDao;

    public List<Book> getList() {
        return bookDao.getList();
    }

    //查询书籍列表
    public PageInfo<Book> pageBook(Book book, Integer pageNum, Integer pageSize) {
        PageInfo<Book> page = null;
        PageHelper.startPage(pageNum, pageSize);
        List<Book> uList = bookDao.listBook(book);
        page = new PageInfo<Book>(uList);
        return page;
    }

    //添加书籍
    public boolean addBook(Book book) {
        boolean isSuccess = false;
        bookDao.addBook(book);
        isSuccess = true;
        return isSuccess;
    }

    //判断书籍代码是否已存在
    public boolean isIdExist(String bookId){
        boolean isSuccess = false;
        Book book = bookDao.getBookById(bookId);
        if(StringUtils.isEmpty(book)){
            isSuccess = true;
        }
        return isSuccess;
    }

    //判断书籍名称是否已存在
    public boolean isNameExist(String bookName){
        boolean isSuccess = false;
        Book book = bookDao.getBookByName(bookName);
        if(StringUtils.isEmpty(book)){
            isSuccess = true;
        }
        return isSuccess;
    }

    //登记
    public boolean checkBook(String bookId) {
        boolean isSuccess = false;
        bookDao.checkBook(bookId);
        isSuccess = true;
        return isSuccess;
    }
}
