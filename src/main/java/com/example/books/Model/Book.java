package com.example.books.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Book {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column
    private String name;
    @Column
    private String author;
    @Column
    private int price;

    public Book(){};

    public Book( String name, String author, int price){
        this.name=name;
        this.author=author;
        this.price=price;
    }

    public void setId(Long id){
        this.id=id;
    }
    public void setName(String name){
        this.name=name;
    }
    public void setAuthor(String author){
        this.author = author;
    }
    public void setPrice(int price){
        this.price=price;
    }

    public long getId(){
        return this.id;
    }
    public String getName(){
        return this.name;
    }
    public String getAuthor(){
        return this.author;
    }
    public int getPrice(){
        return this.price;
    }

}
