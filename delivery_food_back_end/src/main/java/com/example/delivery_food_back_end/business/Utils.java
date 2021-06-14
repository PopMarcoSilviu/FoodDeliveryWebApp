package com.example.delivery_food_back_end.business;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Utils
{
    public static List<String> readFile()
    {
        List<String> data = new ArrayList<>();
        try
        {
            File myObj = new File("src/main/resources/static/products.csv");
            Scanner myReader = new Scanner(myObj);

            while (myReader.hasNextLine())
            {
                String line = myReader.nextLine();
                data.add(line);
            }
        } catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }


        return data;
    }

    public static MenuItem createMenuItem(List<String> values)
    {
        BaseProduct baseProduct = new BaseProduct();
        int i = 0;

        for (var item : baseProduct.getClass().getDeclaredFields())
        {
            if (item.getName().equals("serialVersionUID"))
                continue;

            Object value;

            try
            {
                value = Double.parseDouble(values.get(i));

            } catch (Exception e)
            {
                value = String.valueOf(values.get(i));
            }

            try
            {
                PropertyDescriptor propertyDescriptor = new PropertyDescriptor(item.getName(), BaseProduct.class);
                Method method = propertyDescriptor.getWriteMethod();
                method.invoke(baseProduct, value);
                i++;
            } catch (IntrospectionException | IllegalAccessException | InvocationTargetException e)
            {
                e.printStackTrace();
            }

        }

        return baseProduct;
    }

    public static String objectListToString(List<Object> list)
    {
        StringBuilder result = new StringBuilder();

        if(list == null)
            return null;

        for (var item : list)
        {
            for (var field : item.getClass().getDeclaredFields())
            {

                if (field.getName().equals("serialVersionUID") || field.getName().equals("products"))
                    continue;

                result.append(field.getName()).append(": ");

                for (Method method : item.getClass().getMethods())
                {
                    if (method.getName().startsWith("get") &&
                            method.getName().toLowerCase().contains((field.getName()).toLowerCase()))
                    {
                        try
                        {
                            result.append(method.invoke(item));
                        } catch (IllegalAccessException | InvocationTargetException e)
                        {
                            e.printStackTrace();
                        }
                    }
                }
                result.append("  ");

            }

            result.append('\n');
        }

        if(list.get(0) instanceof MenuItem)
        {
           result.append("price: ");

           result.append(list.stream().filter(e -> e instanceof MenuItem)
                   .map(t -> ((MenuItem) t).computePrice()).mapToDouble(e -> e).sum());
        }

        return result.toString();
    }

    public static boolean checkForRegistrationAndCreateAccount(String username, String password, String userType)
    {
        boolean alreadyExists = DeliveryService.deliveryService.getAccounts().stream()
                .anyMatch(e -> (e.getPassword().equals(password) && e.getUsername().equals(username)));

        if (!alreadyExists)
        {
            DeliveryService.deliveryService.getAccounts()
                    .add(new Account(password, username, UserType.valueOf(userType.substring(userType.indexOf(".") + 1))));

        }

        return alreadyExists;
    }

    public static Account checkForLogin(String username, String password)
    {
        return DeliveryService.deliveryService.getAccounts().stream()
                .filter(e -> (e.getUsername().equals(username) && e.getPassword().equals(password)))
                .findAny().orElse(null);
    }

    public static void modifyProduct(BaseProduct oldProduct, BaseProduct newProduct)
    {
        DeliveryService.deliveryService.getData().stream()
                .filter(menuItem -> menuItem.getTitle().equals(oldProduct.getTitle())).findAny()
                .ifPresent(old -> {
                    old.setRating(newProduct.getRating());
                    old.setCalories(newProduct.getCalories());
                    old.setFat(newProduct.getFat());
                    old.setPrice(newProduct.getPrice());
                    old.setProtein(newProduct.getProtein());
                    old.setSodium(newProduct.getSodium());
                    old.setTitle(newProduct.getTitle());
                });

    }
}
