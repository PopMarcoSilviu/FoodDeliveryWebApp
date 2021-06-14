import 'package:delivery_food_front_end/data/Account.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/pages/operation.pages/AddProductPage.dart';
import 'package:delivery_food_front_end/pages/operation.pages/DeleteProductPage.dart';
import 'package:delivery_food_front_end/pages/operation.pages/Reports.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'operation.pages/AddCompoundProductPage.dart';

class AdminPage extends StatefulWidget {
  AdminPage(
      {Key? key,
      required this.title,
      required this.list,
      required this.account})
      : super(key: key);

  final String title;
  final List<MenuItem> list;
  final Account account;

  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                width: 500.0,
                height: 100.0,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddProductPage('Add Product')));
                    },
                    child: Text('Add product',
                        style: Theme.of(context).textTheme.headline6))),
            Container(
                width: 500.0,
                height: 100.0,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeleteModifyProductPage(
                                  title: 'Modify products',
                                  list: widget.list)));
                    },
                    child: Text('Delete/Modify product',
                        style: Theme.of(context).textTheme.headline6))),
            Container(
              width: 500.0,
              height: 100.0,
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCompoundProductPage(
                                title: 'Compound product',
                                productListBase: widget.list,
                                account: widget.account)));
                  },
                  child: Text(
                    'Create new compound product',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              width: 500.0,
              height: 100.0,
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  importFromCsv();
                },
                child: Text(
                  'Import from csv',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Container(
              width: 500.0,
              height: 100.0,
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reports(title: 'Reports')));
                },
                child: Text(
                  'Create reports',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
