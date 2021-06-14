package com.example.delivery_food_back_end.exceptions;

public class FileAlreadyExistsException extends Exception
{
    public FileAlreadyExistsException(String message)
    {
        super(message);
    }
}
