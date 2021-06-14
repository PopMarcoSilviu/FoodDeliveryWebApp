package com.example.delivery_food_back_end;

import com.example.delivery_food_back_end.business.*;
import com.example.delivery_food_back_end.business.MenuItem;
import com.google.gson.Gson;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@SuppressWarnings("ALL")
@Controller
public class ApiController implements PropertyChangeListener
{

    SimpMessagingTemplate simpMessagingTemplate;

    public ApiController(SimpMessagingTemplate simpMessagingTemplate)
    {
        this.simpMessagingTemplate = simpMessagingTemplate;
        DeliveryService.deliveryService.addPropertyChangeListener(this);
    }

    @ResponseBody
    @GetMapping(value = "/initialDataBase")
    public List<MenuItem> menuItemsGetBase()
    {
        return DeliveryService.deliveryService.getData().stream()
                .filter(e -> e instanceof BaseProduct).collect(Collectors.toList());

    }

    @ResponseBody
    @GetMapping(value = "/initialAccounts")
    public List<Account> accountsGet()
    {
        return DeliveryService.deliveryService.getAccounts();
    }

    @ResponseBody
    @GetMapping(value = "/initialDataComposite")
    public List<MenuItem> menuItemsGetComposite()
    {
        return DeliveryService.deliveryService.getData().stream()
                .filter(e -> e instanceof CompositeProduct).collect(Collectors.toList());
    }


    @ResponseBody
    @PostMapping(value = "/orderPost")
    public void orderPost(@RequestBody String body)
    {

        Gson gson = new Gson();

        var map = gson.fromJson(body, Map.class);

        List<MenuItem> listOrderedProducts = (List) gson.fromJson(gson.toJsonTree(map.get("products")), List.class).stream()
                .map(e -> gson.fromJson(gson.toJsonTree(e), BaseProduct.class)).collect(Collectors.toList());

        Integer clientID = gson.fromJson(gson.toJsonTree(map.get("clientID")), Integer.class);

//        System.out.println(clientID + " " + listOrderedProducts.size());
        DeliveryService.deliveryService.createOrder(clientID, listOrderedProducts);
    }

    @ResponseBody
    @PostMapping(value ="/createCompoundProduct")
    public void createCompoundProduct(@RequestBody String body)
    {
        Gson gson = new Gson();

        var map = gson.fromJson(body, Map.class);
        List<MenuItem> list = (List) gson.fromJson(gson.toJsonTree(map.get("list")),List.class).stream()
                .map(e-> gson.fromJson(gson.toJsonTree(e), BaseProduct.class)).collect(Collectors.toList());

        String title = gson.fromJson(gson.toJsonTree(map.get("title")), String.class);
        Double price = gson.fromJson(gson.toJsonTree(map.get("price")), Double.class);

        DeliveryService.deliveryService.addMenuItem(new CompositeProduct(list, title, price));

    }

    @ResponseBody
    @PostMapping(value = "/reportTime")
    public void reportTime(@RequestBody String body)
    {
        Gson gson = new Gson();

        var map = gson.fromJson(body, Map.class);

        String start = gson.fromJson(gson.toJsonTree(map.get("start")), String.class);
        String finish = gson.fromJson(gson.toJsonTree(map.get("finish")), String.class);

        DeliveryService.deliveryService.generateReportTimeInterval(LocalTime.parse(start),LocalTime.parse(finish));
    }

    @ResponseBody
    @PostMapping(value = "/addProductBase")
    public void productPost(@RequestBody String body)
    {
        Gson gson = new Gson();

        BaseProduct item = gson.fromJson(body,BaseProduct.class);
        System.out.println(item.getTitle());
        DeliveryService.deliveryService.addMenuItem(item);

    }



    @ResponseBody
       @PostMapping(value = "/checkForRegistration")
    public boolean checkForRegistration(@RequestBody String body)
    {
        Gson gson = new Gson();

        var map = gson.fromJson(body, Map.class);

        String username = gson.fromJson(gson.toJsonTree(map.get("username")), String.class);
        String password = gson.fromJson(gson.toJsonTree(map.get("password")), String.class);
        String userType = gson.fromJson(gson.toJsonTree(map.get("userType")), String.class);

        return Utils.checkForRegistrationAndCreateAccount(username, password, userType);

    }


    @ResponseBody
    @PostMapping(value="/deletePostItem")
    public void deletePostItem(@RequestBody String body)
    {
        Gson gson = new Gson();
        var name = gson.fromJson(body, String.class);

        DeliveryService.deliveryService.deleteMenuItem(name);
    }

    @ResponseBody
    @PostMapping(value = "/checkForLogin")
    public Account checkForLogin(@RequestBody String body)
    {

        Gson gson = new Gson();

        var map = gson.fromJson(body, Map.class);

        String username = gson.fromJson(gson.toJsonTree(map.get("username")), String.class);
        String password = gson.fromJson(gson.toJsonTree(map.get("password")), String.class);

        return Utils.checkForLogin(username, password);
    }

    @ResponseBody
    @PostMapping(value="/modifyProduct")
    public void modifyProduct(@RequestBody String body)
    {
        Gson gson = new Gson();
        var map = gson.fromJson(body,Map.class);
        BaseProduct oldProduct = gson.fromJson(gson.toJsonTree(map.get("old")), BaseProduct.class);
        BaseProduct newProduct = gson.fromJson(gson.toJsonTree(map.get("new")), BaseProduct.class);

        Utils.modifyProduct(oldProduct, newProduct);

    }

    @GetMapping(value="/importFromCsv")
    public void importFromCsv()
    {
        DeliveryService.deliveryService.importFromCsv();
    }

    @Override
    public void propertyChange(PropertyChangeEvent evt)
    {

        Gson gson = new Gson();
        Order newOrder = (Order) evt.getNewValue();
        SendOrder sendOrder = new SendOrder(newOrder, DeliveryService.deliveryService.getOrderData().get(newOrder));

        simpMessagingTemplate.convertAndSend("/employees", gson.toJson(sendOrder));
    }


}
