package com.example.delivery_food_back_end.business;


import com.example.delivery_food_back_end.data.CreateReport;
import com.example.delivery_food_back_end.data.Serializer;
import com.example.delivery_food_back_end.data.Wrapper;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;


/**
 * @Invariant isWellFormed()
 */
public class DeliveryService implements IDeliveryServiceProcessing
{

    public static DeliveryService deliveryService = new DeliveryService();
    private PropertyChangeSupport pcs ;
    private Map<Order, List<MenuItem>> orderData = new HashMap<>();
    private List<MenuItem> data = new ArrayList<>();
    private List<Account> accounts = new ArrayList<>();

    public DeliveryService(Map<Order, List<MenuItem>> orderData, List<MenuItem> data, List<Account> accounts)
    {
        this.orderData = orderData;
        this.data = data;
        this.accounts = accounts;
    }

    private boolean isWellFormed()
    {
        if(orderData == null)
            return false;

        if(data == null)
            return false;

        return accounts != null;
    }

    public DeliveryService()
    {
        assert isWellFormed();
        pcs = new PropertyChangeSupport(this);
        loadData();
        assert isWellFormed();
    }

    public void saveData()
    {
        assert isWellFormed();
        var toSave = new Wrapper(orderData, data, accounts);
        Serializer serializer = new Serializer();

        serializer.serialize(toSave);
        assert isWellFormed();
    }

    public List<Account> getAccounts()
    {
        assert isWellFormed();
        return accounts;
    }

    public void loadData()
    {
        assert isWellFormed();
        Serializer serializer = new Serializer();
        var toLoad = (Wrapper) serializer.deserialize();


        try
        {
            orderData = toLoad.getOrderData();
            data = toLoad.getData();
            accounts = toLoad.getAccounts();
        } catch (Exception e)
        {
            e.printStackTrace();
        }

        assert isWellFormed();
    }

    public void addPropertyChangeListener(PropertyChangeListener p)
    {
        pcs.addPropertyChangeListener(p);
    }

    @Override
    public void addMenuItem(MenuItem menuItem)
    {
        assert isWellFormed();
        assert menuItem!=null;
        data.add(menuItem);
        assert isWellFormed();
    }

    @Override
    public void createOrder(int clientID, List<MenuItem> list)
    {
        assert isWellFormed();
        assert clientID>0;
        assert list!=null;
        Order order = new Order(clientID);
        orderData.put(order, list);
        pcs.firePropertyChange("order", null, order);
        assert isWellFormed();
    }

    @Override
    public void deleteMenuItem(int id)
    {
        assert isWellFormed();
        assert id >0 ;
        data.removeIf(item -> item.idProduct == id);
        assert isWellFormed();
    }


    public void deleteMenuItem(String name)
    {
        assert isWellFormed();
        assert name !=null;
        assert !name.equals("");
        data.removeIf(item -> item.getTitle().equals(name));
        assert isWellFormed();
    }


    @Override
    public void modifyMenuItem(int id, MenuItem menuItem)
    {
        assert isWellFormed();
        assert id>0;
        assert menuItem !=null;
        data.stream().filter(e -> e.idProduct == id).forEach(x -> data.set(data.indexOf(x), menuItem));
        assert isWellFormed();
    }

    @Override
    public void importFromCsv()
    {
        assert isWellFormed();
        var rawData = Utils.readFile();
        rawData.remove(0);

        for (var item : rawData)
        {
            String newItem = item.replaceAll("\"", " ");
            List<String> values = Arrays.asList(newItem.split("\\s*,\\s*"));

            if (data != null &&
                    data.stream().anyMatch(x ->
                            x.getTitle().equals(values.get(0))))
            {
                continue;
            }

            BaseProduct newBaseProduct = (BaseProduct) Utils.createMenuItem(values);

            data.add(newBaseProduct);
        }
        assert isWellFormed();
    }

    @Override
    public void generateReportTimeInterval(LocalTime a, LocalTime b)
    {
        assert isWellFormed();
        assert a!=null;
        assert b!=null;
        List<Object> match = new ArrayList<>();


        orderData.entrySet().stream()
                .filter(e -> (e.getKey().getOrderDate().toLocalTime().compareTo(a) > 0 &&
                        b.compareTo(e.getKey().getOrderDate().toLocalTime()) > 0)).forEach(match::add);

        CreateReport.createReport(match);
        assert isWellFormed();

    }

    @Override
    public void generateReportForNbOfProducts(int nb)
    {
        assert isWellFormed();
        assert nb >0;
        List<Object> match = new ArrayList<>();

        int[] productFreq = new int[MenuItem.id + 1];
        Arrays.fill(productFreq, 0);

        orderData.forEach((key, value) -> value.forEach(t ->
                productFreq[t.idProduct]++));

        for (int i = 0; i < productFreq.length; i++)
        {
            if (productFreq[i] >= nb)
            {
                int finalI = i;
                match.add(data.stream().filter(e -> e.idProduct == finalI).findFirst().orElse(null));
            }
        }


        CreateReport.createReport(match);
        assert isWellFormed();
    }

    @Override
    public void generateReportClientsValueAndNbOfTimes(int nb, int valueMin)
    {
        assert isWellFormed();
        assert nb >0;
        assert valueMin > 0;
        List<Object> list = new ArrayList<>();

        orderData.entrySet().stream().filter(e -> e.getValue().stream().mapToDouble(MenuItem::computePrice).sum() < valueMin)
                .forEach(t ->
                {
                    if (orderData.entrySet().stream().filter(x -> x.getKey().getClientID() == t.getKey().getClientID()).count() >= nb)
                    {
                        list.add(t.getKey());
                    }
                });

        CreateReport.createReport(list);
        assert isWellFormed();
    }

    @Override
    public void generateReportSpecificDay(LocalDate date)
    {
        assert isWellFormed();
        assert date !=null;
        int[] productFreq = new int[MenuItem.id + 1];
        List<Object> list = new ArrayList<>();


        data.forEach(e -> orderData.entrySet().stream().filter(t -> t.getKey().getOrderDate().toLocalDate().compareTo(date) == 0)
                .forEach(x -> productFreq[e.idProduct]++));

        for (int i = 0; i < productFreq.length; i++)
        {
            if (productFreq[i] > 0)
            {
                int finalI = i;
                BaseProductNumbered baseProductNumbered = new BaseProductNumbered
                        ((BaseProduct) Objects.requireNonNull(data.stream().
                                filter(e -> e.idProduct == finalI).findFirst().orElse(null)), productFreq[i]);

                list.add(baseProductNumbered);
            }
        }

        CreateReport.createReport(list);
        assert isWellFormed();
    }

    public Map<Order, List<MenuItem>> getOrderData()
    {
        assert isWellFormed();
        return orderData;
    }

    public List<MenuItem> getData()
    {
        assert isWellFormed();
        return data;
    }

    public void createAccount(String password, String username, UserType userType)
    {
        assert isWellFormed();
        Account newAccount = new Account(password, username, userType);
        accounts.add(newAccount);
        assert isWellFormed();
    }

}
