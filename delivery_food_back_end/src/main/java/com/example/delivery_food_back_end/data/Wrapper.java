package com.example.delivery_food_back_end.data;

import com.example.delivery_food_back_end.business.Account;
import com.example.delivery_food_back_end.business.MenuItem;
import com.example.delivery_food_back_end.business.Order;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class Wrapper implements Serializable
{
    Map<Order, List<MenuItem>> orderData;
    List<MenuItem> data;
    List<Account> accounts;

    public Wrapper(Map<Order, List<MenuItem>> orderData, List<MenuItem> data, List<Account> accounts)
    {
        this.orderData = orderData;
        this.data = data;
        this.accounts = accounts;
    }

    public Map<Order, List<MenuItem>> getOrderData()
    {
        return orderData;
    }

    public void setOrderData(Map<Order, List<MenuItem>> orderData)
    {
        this.orderData = orderData;
    }

    public List<MenuItem> getData()
    {
        return data;
    }

    public void setData(List<MenuItem> data)
    {
        this.data = data;
    }

    public List<Account> getAccounts()
    {
        return accounts;
    }

    public void setAccounts(List<Account> accounts)
    {
        this.accounts = accounts;
    }
}
