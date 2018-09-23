package com.smart.dao;

import com.smart.bean.Book;

import java.util.List;

public interface bookDao {

    public List<Book> getList();
    //书籍列表
    public List<Book> listBook(Book book);
    //添加书籍
    public void addBook(Book book);
    //通过Id获取书籍
    public Book getBookById(String bookId);
    //通过书名获取书籍
    public Book getBookByName(String bookName);
    //登记
    public void checkBook(String bookId);

}
