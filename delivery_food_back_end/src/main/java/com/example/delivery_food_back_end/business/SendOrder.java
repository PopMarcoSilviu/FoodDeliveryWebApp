package com.example.delivery_food_back_end.business;

import java.awt.*;
import java.util.List;

public class SendOrder
{
    private int orderID ;
    private int clientID;
    private String orderDate;
    private List<MenuItem> list;

    public SendOrder(Order order, List<MenuItem> list)
    {
        this.orderID = order.getOrderID();
        this.clientID = order.getClientID();
        this.orderDate = order.getOrderDate().toString();
        this.list = list;
    }

    public List<MenuItem> getList()
    {
        return list;
    }

    public void setList(List<MenuItem> list)
    {
        this.list = list;
    }

    public int getOrderID()
    {
        return orderID;
    }

    public void setOrderID(int orderID)
    {
        this.orderID = orderID;
    }

    public int getClientID()
    {
        return clientID;
    }

    public void setClientID(int clientID)
    {
        this.clientID = clientID;
    }

    public String getOrderDate()
    {
        return orderDate;
    }

    public void setOrderDate(String orderDate)
    {
        this.orderDate = orderDate;
    }
}
