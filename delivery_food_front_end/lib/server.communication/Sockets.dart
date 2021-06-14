import 'dart:convert';

import 'package:delivery_food_front_end/Pages/EmployeePage.dart';
import 'package:delivery_food_front_end/data/Order.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void onConnect(StompFrame frame) {

  stompClient.subscribe(
      destination: '/employees',
      callback: (frame) {
        var responseJson = jsonDecode(frame.body!);

        Order order = Order.fromJson(responseJson);
        streamController.add(order);

      });
}

final StompClient stompClient = StompClient(
  config: StompConfig(
    url: 'ws://localhost:8080/notification',
    onConnect: onConnect,
    beforeConnect: () async {
      print('connecting');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
    // onDebugMessage: (error) => print(error.toString()),
  ),
);
