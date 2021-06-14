package com.example.delivery_food_back_end.business;

import com.example.delivery_food_back_end.data.CreateReport;

import java.io.Serializable;

public class Account implements Serializable
{
    private static int currentId = 0;
    private int id;
    private String password;
    private String username;
    private UserType userType;


    public Account(String password, String username, UserType userType)
    {
        this.password = password;
        this.username = username;
        this.userType = userType;
        this.id = CreateReport.getAndUpdateNumberFromFile("src/main/resources/reports/AccountID");
    }

    public int getId()
    {
        return id;
    }

    public String getPassword()
    {
        return password;
    }

    public String getUsername()
    {
        return username;
    }

    public UserType getUserType()
    {
        return userType;
    }
}
