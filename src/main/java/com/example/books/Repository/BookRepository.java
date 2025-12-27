package com.example.books.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.books.Model.*;

@Repository
public interface BookRepository extends JpaRepository<Book,Long>{
    
    @Query(value = "select * from book where author = :author", nativeQuery = true)
    public List<Book> findByAuthor(@Param("author") String author);
}
