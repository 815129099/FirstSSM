package com.smart.controller;

import com.github.pagehelper.PageInfo;
import com.smart.bean.Book;
import com.smart.service.bookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/")
public class bookController {

    @Autowired
    private bookService bookService;

    @RequestMapping(value="/index")
    public ModelAndView index() {
        return new ModelAndView("index1");
    }

    @RequestMapping(value="/maSystem")
    public ModelAndView maSystem() {
        return new ModelAndView("maSystem");
    }

    @RequestMapping(value="/meList")
    public ModelAndView meList() {
        return new ModelAndView("meList");
    }

    // 用户列表
    @RequestMapping("/bookList")
    @ResponseBody
    public Map<String, Object> bookList() throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Book> list = bookService.getList();
        for (Book b :
                list) {
            System.out.println(b.getBookId()+","+b.getBookName());
        }
        map.put("list",list);
        return map;
    }

    //查询书籍列表
    @RequestMapping("/listBook.do")
    @ResponseBody
    public Map<String,Object> listBook(Book book,Integer pageNum,Integer pageSize)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
            //获取分页信息
            if (pageNum == null || pageNum == 0) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 15;
            }
            if (book.getBookName() != null) {
                System.out.print(book.getBookName());
                book.setBookName("%" + book.getBookName() + "%");
            }
            if(book.getBookLocation() != null){
                System.out.print(book.getBookLocation());
                book.setBookLocation("%" + book.getBookLocation() + "%");
            }
            PageInfo<Book> page = bookService.pageBook(book, pageNum, pageSize);
            map.put("page", page);

        return map;
    }

    //添加书籍
    @RequestMapping("/addBook.do")
    @ResponseBody
    public Map<String,Object> addBook(Book book) throws IOException {
        Map<String,Object> map = new HashMap<String,Object>();
        boolean isSuccess = bookService.addBook(book);
        if(isSuccess){
            map.put("tip", "success");
        }
        else{
            map.put("tip", "error");
        }
        return map;
    }

    //添加书籍
    @RequestMapping("/checkBook.do")
    @ResponseBody
    public Map<String,Object> checkBook(String bookId) throws IOException {
        Map<String,Object> map = new HashMap<String,Object>();
        if(!StringUtils.isEmpty(bookId)){
            System.out.print(bookId);
        }
       else{
            System.out.print("11111111111");
        }
        boolean isSuccess = bookService.checkBook(bookId);
        if(isSuccess){
            map.put("tip", "success");
        }
        else{
            map.put("tip", "error");
        }
        return map;
    }

    // 判断书籍代码是否已存在
    @RequestMapping("/isIdExist.do")
    @ResponseBody
    public Map<String, Object> isIdExist(String bookId) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        boolean isSuccess = bookService.isIdExist(bookId);
        if (isSuccess) {
            result.put("tip", "success");
        } else {
            result.put("tip", "error");
        }

        return result;
    }

    // 判断书籍名称是否已存在
    @RequestMapping("/isNameExist.do")
    @ResponseBody
    public Map<String, Object> isNameExist(String bookName) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        boolean isSuccess = bookService.isNameExist(bookName);
        if (isSuccess) {
            result.put("tip", "success");
        } else {
            result.put("tip", "error");
        }

        return result;
    }



}
