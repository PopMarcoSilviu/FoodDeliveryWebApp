package com.example.delivery_food_back_end.business;

import java.awt.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

public interface IDeliveryServiceProcessing
{
    /**
     * @param menuItem
     * @pre menuItem != null
     */
    void addMenuItem(MenuItem menuItem);

    /**
     * @param clientId
     * @param list
     * @pre clientId >0 and list !=null
     */
    void createOrder(int clientId, List<MenuItem> list);

    /**
     * @param id
     * @pre id> 0
     */
    void deleteMenuItem(int id);

    /**
     * @param id
     * @param menuItem
     * @pre id> 0 and menuItem != null
     */
    void modifyMenuItem(int id, MenuItem menuItem);

    /**
     * imports data from csv
     */
    void importFromCsv();

    /**
     * @param a
     * @param b
     * @pre a, b != null
     */
    void generateReportTimeInterval(LocalTime a, LocalTime b);

    /**
     * @param nb
     * @pre nb > 0
     */
    void generateReportForNbOfProducts(int nb);

    /**
     * @param nb
     * @param value
     * @pre nb >0 and value > 0
     */
    void generateReportClientsValueAndNbOfTimes(int nb, int value);

    /**
     * @param date
     * date !=null
     */
    void generateReportSpecificDay(LocalDate date);


}
