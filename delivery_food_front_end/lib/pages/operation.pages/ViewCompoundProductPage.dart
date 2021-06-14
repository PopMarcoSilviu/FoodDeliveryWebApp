
import 'package:delivery_food_front_end/data/Account.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/TempProductCreate.dart';
import '../../Utils/utils.dart';


class ViewCompoundProductPage extends StatefulWidget {
  ViewCompoundProductPage(
      {Key? key,
        required this.title,
        required this.list,
        required this.account})
      : super(key: key);

  final String title;
  final List<MenuItem> list;
  final Account account;

  _ViewCompoundProductPage createState() => _ViewCompoundProductPage();
}

class _ViewCompoundProductPage extends State<ViewCompoundProductPage> {

  late double price;
  String title = '';

  @override
  void initState() {
    super.initState();
    price = widget.list.map((e) => e.price).reduce((value, element) => value + element);
  }

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
              child: createListViewOfProductOrder(context, widget.list),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 100.0,

                    child: TextFormField(
                      onChanged: (text)
                      {
                        price = double.parse(text);
                      },
                      decoration: InputDecoration(
                        hintText: widget.list.map((e) => e.price).reduce((value, element) => value + element).toString(),
                        labelText: 'Price',

                      ),
                    )
                ),

                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 100.0,

                    child: TextFormField(
                      onChanged: (text)
                      {
                        title = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Product name',
                        labelText: 'Title',

                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 100.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          createCompoundProduct(widget.list, title, price);
                          setState(() {
                            widget.list.clear();
                          });
                        },
                        child: Text('Finish Creation'))
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    width: 220.0,
                    height: 100.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            widget.list.clear();
                          });
                        },
                        child: Text('Cancel'))),
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
