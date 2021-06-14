package com.example.delivery_food_back_end.business;

public class BaseProductNumbered
{

    private String title;
    private double rating;
    private double calories;
    private double protein;
    private double fat;
    private double sodium;
    private double price;
    private int number;


    public BaseProductNumbered(BaseProduct baseProduct,int number)
    {
       this.number = number;
       this.calories = baseProduct.getCalories();
       this.protein = baseProduct.getProtein();
       this.fat = baseProduct.getFat();
       this.price = baseProduct.computePrice();
       this.sodium = baseProduct.getSodium();
       this.rating = baseProduct.getRating();
       this.title = baseProduct.getTitle();
    }

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

    public int getNumber()
    {
        return number;
    }

    public void setNumber(int number)
    {
        this.number = number;
    }
}
