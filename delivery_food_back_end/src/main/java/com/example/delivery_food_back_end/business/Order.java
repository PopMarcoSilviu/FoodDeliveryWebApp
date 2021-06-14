package com.example.delivery_food_back_end.business;

import com.example.delivery_food_back_end.data.CreateReport;

import java.io.Serializable;
import java.time.LocalDateTime;

import java.util.Objects;

public class Order implements Serializable
{
    private static final long serialVersionUID = 123L;
    private int orderID ;
    private int clientID;
    private LocalDateTime orderDate;


    public Order(int clientID)
    {
        this.orderID = CreateReport.getAndUpdateNumberFromFile("src/main/resources/reports/OrderID");
        this.clientID = clientID;
        this.orderDate = LocalDateTime.now();
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return orderID == order.orderID && clientID == order.clientID && Objects.equals(orderDate, order.orderDate);
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(orderID, clientID, orderDate);
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

    public LocalDateTime getOrderDate()
    {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate)
    {
        this.orderDate = orderDate;
    }
}
