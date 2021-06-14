
import 'package:delivery_food_front_end/data/Account.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/TempProductCreate.dart';
import '../Utils/utils.dart';

class OrderPage extends StatefulWidget {
  OrderPage(
      {Key? key,
      required this.title,
      required this.order,
      required this.account})
      : super(key: key);

  final String title;
  final List<MenuItem> order;
  final Account account;

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(150.0, 80.0, 0, 0),
              child: createListViewOfProductOrder(context, widget.order),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Container(
                  width: 200.0,
                  height: 70.0,

                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('Price: ' + widget.order.fold(0.0,
                            (double previousValue, element) => previousValue+ element.price).toString(),
                      style: Theme.of(context).textTheme.button,)),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 80.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          postOrderData(widget.account.id, widget.order);

                          setState(() {
                            widget.order.clear();
                          });
                        },
                        child: Text('Finish Order'))),
                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 80.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            widget.order.clear();
                          });
                        },
                        child: Text('Delete Order'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container getRowOrder(context, item) {
  return Container(
    alignment: Alignment.center,
    child: Row(children: [
      createTableCell(
          context, item.title, Theme.of(context).textTheme.bodyText1),
      createTableCell(context, item.rating.toString(),
          Theme.of(context).textTheme.bodyText1),
      createTableCell(context, item.calories.toString(),
          Theme.of(context).textTheme.bodyText1),
      createTableCell(context, item.protein.toString(),
          Theme.of(context).textTheme.bodyText1),
      createTableCell(
          context, item.fat.toString(), Theme.of(context).textTheme.bodyText1),
      createTableCell(context, item.sodium.toString(),
          Theme.of(context).textTheme.bodyText1),
      createTableCell(context, item.price.toString(),
          Theme.of(context).textTheme.bodyText1),
    ]),
  );
}

Container createListViewOfProductOrder(context, List<MenuItem> list) {
  var fieldNameList = fieldNamesForProduct();

  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 20.0),
          height: 100.0,
          width: 1000.0,
          child: Row(children: [
            for (var item in fieldNameList)
              createTableCell(
                  context, item, Theme.of(context).textTheme.headline2),
          ]),
        ),
        Container(
          alignment: Alignment.center,
          height: 530.0,
          width: 1000.0,
          child: ListView.separated(
              padding: EdgeInsets.all(5.0),
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return getRowOrder(context, list[index]);
              },
              separatorBuilder: (context, position) {
                return separatorCreate();
              }),
        ),
      ],
    ),
  );
}
