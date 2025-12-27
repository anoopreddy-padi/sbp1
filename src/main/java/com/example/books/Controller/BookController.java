package com.example.books.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.books.Exceptions.ResourceNotFoundException;
import com.example.books.Model.*;
import com.example.books.Repository.BookRepository;


@RestController
@RequestMapping("/api/v1/book")
public class BookController {
    
    @Autowired
    private BookRepository bookRepository;

    @GetMapping("/all")
    public List<Book> getAllBooks(){
        System.out.println("from getAllBooks");
        return this.bookRepository.findAll();
    }

    @GetMapping("/{id}")
    public Book getBookById(@PathVariable long id){
        Optional<Book> book = this.bookRepository.findById(id);
        if(!book.isPresent()){
            throw new ResourceNotFoundException(String.format("Book with id %d not found", id));
        }
        return book.get();
    }

    @PostMapping("/add")
    public Book addBook(@RequestBody Book book){
        return this.bookRepository.save(book);
    }

    @PutMapping("/update/{id}")
    public Book putBook(@PathVariable long id, @RequestBody Book book){
        Optional<Book> existingBook = this.bookRepository.findById(id);
        if (!existingBook.isPresent()){
            throw new ResourceNotFoundException(String.format("Book with id %d not found", id));
        }
        book.setId(id);
        return this.bookRepository.save(book);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteBook(@PathVariable long id){
        Optional<Book> book = this.bookRepository.findById(id);
        if (!book.isPresent()){
            throw new ResourceNotFoundException(String.format("Book with id %d not found", id));
        }
        this.bookRepository.deleteById(id);
    }

    @GetMapping("/")
    public List<Book> getBooksByAuthor(@RequestParam String author){
        System.out.println("from getBooksByAuthor");
        return this.bookRepository.findByAuthor(author);
    }

}
