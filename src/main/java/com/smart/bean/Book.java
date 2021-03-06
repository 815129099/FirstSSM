package com.smart.bean;

public class Book {
    private int id;
    private int bookNumber;
    private String bookId;
    private String bookName;
    private int lendNumber;
    private String bookLocation;

    public int getId() {
        return id;
    }

    public int getBookNumber() {
        return bookNumber;
    }

    public String getBookId() {
        return bookId;
    }

    public String getBookLocation() {
        return bookLocation;
    }

    public String getBookName() {
        return bookName;
    }



    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public void setBookLocation(String bookLocation) {
        this.bookLocation = bookLocation;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public void setBookNumber(int bookNumber) {
        this.bookNumber = bookNumber;
    }

    public int getLendNumber() {
        return lendNumber;
    }

    public void setLendNumber(int lendNumber) {
        this.lendNumber = lendNumber;
    }

    public void setId(int id) {
        this.id = id;
    }
}
