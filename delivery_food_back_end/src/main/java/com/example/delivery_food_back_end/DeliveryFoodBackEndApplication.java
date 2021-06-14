package com.example.delivery_food_back_end;


import com.example.delivery_food_back_end.business.DeliveryService;
import com.example.delivery_food_back_end.close.operation.ServerInterface;

import com.example.delivery_food_back_end.data.CreateReport;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

import java.util.ArrayList;
import java.util.List;


@ServletComponentScan
@SpringBootApplication
public class DeliveryFoodBackEndApplication
{

    public static void main(String[] args)
    {
        ServerInterface serverInterface = new ServerInterface();
        SpringApplication.run(DeliveryFoodBackEndApplication.class, args);


//		DeliveryService.deliveryService.importFromCsv();
//		DeliveryService.deliveryService.saveData();
//		DeliveryService.deliveryService.loadData();
//		System.out.println(DeliveryService.deliveryService.getData().size());
//		System.out.println(DeliveryService.deliveryService.getData());
//		DeliveryService.deliveryService.loadData();
//		System.out.println(DeliveryService.deliveryService.getData());
//		System.out.println(DeliveryService.deliveryService.getAccounts());
//		System.out.println(DeliveryService.deliveryService.getOrderData());


//		List<Object> a = new ArrayList<>();
//		a.add(new Order(1, LocalDateTime.now()));
//		a.add(new Order(2, LocalDateTime.now()));
//		a.add(new Order(3,LocalDateTime.now()));

    }

}
