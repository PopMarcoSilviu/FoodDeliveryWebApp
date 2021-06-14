import 'package:delivery_food_front_end/data/MenuItem.dart';

class Order {
  Order(
      {required this.orderDate,
        required this.clientID,
        required this.orderID,
        required this.list});

  final int orderID;
  final int clientID;
  final String orderDate;
  final List<MenuItem> list;

  factory Order.fromJson(Map<String, dynamic> json) {

    List<MenuItem> listMenu= [];

    for( var item in json['list'])
      {
        listMenu.add(MenuItem.fromJson(item));
      }

    return Order(
        orderDate: json['orderDate'],
        clientID: json['clientID'],
        orderID: json['orderID'],

        list: listMenu,
    );
  }
}
