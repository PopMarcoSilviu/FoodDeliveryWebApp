package com.example.delivery_food_back_end.business;

import java.io.Serializable;

public abstract class MenuItem implements Serializable
{
    static int id = 0;
    int idProduct;
    public abstract double computePrice();

    public abstract void setRating(double rating);

    public abstract double getCalories();

    public abstract void setCalories(double calories);

    public abstract double getProtein();

    public abstract void setProtein(double protein);

    public abstract double getFat();

    public abstract void setFat(double fat);

    public abstract double getSodium();

    public abstract void setSodium(double sodium);

    public abstract double getPrice();

    public abstract void setPrice(double price);

    public abstract String getTitle();

    public abstract void setTitle(String title);
}
