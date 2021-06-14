package com.example.delivery_food_back_end.business;

import com.example.delivery_food_back_end.data.CreateReport;

public class BaseProduct extends MenuItem
{
     private String title;
     private double rating;
     private double calories;
     private double protein;
     private double fat;
     private double sodium;
     private double price;
     private static final long serialVersionUID = 123L;

    public BaseProduct(String title, double rating, double calories, double protein, double fat, double sodium, double price)
    {
        this.title = title;
        this.rating = rating;
        this.calories = calories;
        this.protein = protein;
        this.fat = fat;
        this.sodium = sodium;
        this.price = price;
        id = CreateReport.getAndUpdateNumberFromFile("src/main/resources/reports/idStatus");
        super.idProduct = id;

    }

    public BaseProduct()
    {
        super.idProduct = id++;
    }

    @Override
    public double computePrice()
    {
        return price;
    }


    @Override
    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public double getRating()
    {
        return rating;
    }

    public void setRating(double rating)
    {
        this.rating = rating;
    }

    public double getCalories()
    {
        return calories;
    }

    public void setCalories(double calories)
    {
        this.calories = calories;
    }

    public double getProtein()
    {
        return protein;
    }

    public void setProtein(double protein)
    {
        this.protein = protein;
    }

    public double getFat()
    {
        return fat;
    }

    public void setFat(double fat)
    {
        this.fat = fat;
    }

    public double getSodium()
    {
        return sodium;
    }

    public void setSodium(double sodium)
    {
        this.sodium = sodium;
    }

    public double getPrice()
    {
        return price;
    }

    public void setPrice(double price)
    {
        this.price = price;
    }

    public static long getSerialVersionUID()
    {
        return serialVersionUID;
    }
}
