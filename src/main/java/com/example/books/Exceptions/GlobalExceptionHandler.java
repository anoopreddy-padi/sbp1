package com.example.books.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<Map<String, String>> handleResourceNotFound(ResourceNotFoundException e){
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("error", e.getMessage());
        errorResponse.put("status", "404");
        return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
    }
}