package com.example.delivery_food_back_end.data;

import com.example.delivery_food_back_end.business.MenuItem;
import com.example.delivery_food_back_end.business.Order;
import com.example.delivery_food_back_end.business.Utils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class Bill
{
    public static void create(Order order, Map<Order, List<MenuItem>> orderData)
    {
        List<Object> items = new ArrayList<Object>(Objects.requireNonNull(orderData.entrySet().stream().
                filter(e -> e.getKey().equals(order)).findAny().map(Map.Entry::getValue).orElse(null)));

        double sum = Objects.requireNonNull(items).stream().mapToDouble(e -> ((MenuItem) e).computePrice()).sum();

        File myObj = new File("src/main/resources/bills/" + orderData.size());
        try
        {
            FileWriter fileWriter = new FileWriter("src/main/resources/bills/" + orderData.size());
            String output = "Total sum: " + String.valueOf(sum) + '\n';
            output = output + Utils.objectListToString(items);
            fileWriter.write(output);
            fileWriter.close();
        } catch (IOException e)
        {
            e.printStackTrace();
        }
    }
}
