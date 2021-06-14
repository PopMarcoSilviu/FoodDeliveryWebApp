package com.example.delivery_food_back_end.business;

import com.example.delivery_food_back_end.data.CreateReport;

import java.util.List;

public class CompositeProduct extends MenuItem
{
    private List<MenuItem> products;
    private static final long serialVersionUID = 123L;

    private String title;
    private double rating = 0;
    private double calories = 0;
    private double protein = 0;
    private double fat = 0;
    private double sodium = 0;
    private double price = 0;

    public CompositeProduct(List<MenuItem> products, String name, double price)
    {
        this.title = name;
        this.products = products;
        this.price = price;
        id = CreateReport.getAndUpdateNumberFromFile("src/main/resources/reports/idStatus");
        super.idProduct = id;

        rating = products.stream().mapToDouble(a -> ((BaseProduct)a).getRating()).average().orElse(0.0);
        calories = products.stream().mapToDouble(MenuItem::computePrice).sum();
        protein = products.stream().mapToDouble(MenuItem::getProtein).sum();
        fat = products.stream().mapToDouble(MenuItem::getFat).sum();
        sodium = products.stream().mapToDouble(MenuItem::getSodium).sum();
        this.price = price;

    }


    @Override
    public double computePrice()
    {
        return products.stream().mapToDouble(MenuItem::computePrice).sum();
    }


    public List<MenuItem> getProducts()
    {
        return products;
    }

    public void setProducts(List<MenuItem> products)
    {
        this.products = products;
    }

    public static long getSerialVersionUID()
    {
        return serialVersionUID;
    }

    @Override
    public String getTitle()
    {
        return title;
    }

    @Override
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
}
