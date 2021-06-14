import 'dart:async';

import 'package:delivery_food_front_end/data/Order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

StreamController<Order> streamController = StreamController();

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key, required this.title, required this.stream});

  final String title;
  final Stream<Order> stream;

  _EmployeePageStart createState() => _EmployeePageStart();
}

class _EmployeePageStart extends State<EmployeePage> {
  List<Order> currentAvailableOrders = [];

  @override
  void initState() {
    super.initState();
    widget.stream.listen((orderEvent) {
      setCurrentState(orderEvent);
    });
  }

  void setCurrentState(Order newOrder) {
    setState(() {
      currentAvailableOrders.add(newOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: createViewList(),
      ),
    );
  }

  Scrollbar createViewList() {
    return Scrollbar(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: currentAvailableOrders.length,
        itemBuilder: (context, index) {
          return Center(child: createOrderUI(currentAvailableOrders[index]));
        },
        separatorBuilder: (context, position) {
          return Container(
            height: 25.0,
          );
        },
      ),
    );
  }

  Center createOrderUI(Order ord) {
    return Center(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              createText('Order: ' + ord.orderID.toString()),
              createText('Client: ' + ord.clientID.toString()),
              createText('Date: ' + ord.orderDate),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    onPressed: () {

                     setState(() {
                       currentAvailableOrders.remove(ord);
                     });
                    },
                    child: Text(" TAKE ", style: Theme.of(context).textTheme.headline1,),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[200],
                  ),

                ),
              ),


              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Column(
                    children: [
                      Text('Products', style: Theme.of(context).textTheme.bodyText1,),
                      Container(
                        height: 150.0,
                        width: 400.0,
                        child: Scrollbar(
                          child: ListView.separated(
                            padding: EdgeInsets.all(5.0),
                            itemCount: ord.list.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index)
                            {
                              return Text(ord.list[index].title,
                                style: Theme.of(context).textTheme.bodyText1,);
                            },

                            separatorBuilder: (context, position)
                            {
                              return Container(height: 3.0,);
                            },

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )
      ],
    ),
        ));
  }

  Padding createText(String name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
           name,
            style: Theme.of(context).textTheme.button,
          ),

        ),
      ),
    );
  }
}
