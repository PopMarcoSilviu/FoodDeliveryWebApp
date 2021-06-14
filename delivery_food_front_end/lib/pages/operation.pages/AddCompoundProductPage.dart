import 'dart:math';

import 'package:delivery_food_front_end/data/Account.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Utils/TempProductCreate.dart';
import '../../Utils/utils.dart';
import 'ViewCompoundProductPage.dart';


const value = 10;

class AddCompoundProductPage extends StatefulWidget {
  AddCompoundProductPage(
      {Key? key,
        required this.title,
        required this.productListBase,
        required this.account})
      : super(key: key);
  final String title;
  final List<MenuItem> productListBase;
  final Account account;

  _AddCompoundProductPage createState() => _AddCompoundProductPage();
}

class _AddCompoundProductPage extends State<AddCompoundProductPage> {
  final mySearchController = TextEditingController();
  String filter = '';
  List<MenuItem> order = [];

  late List<RangeValues> _maxRangeValues =
  List<RangeValues>.generate(6, (index) => getRange(index))
      .map((RangeValues e) => RangeValues(log(e.start + 1), log(e.end + 1)))
      .toList();
  late List<RangeValues> _currentRangeValues =
  List<RangeValues>.generate(6, (index) => getRange(index))
      .map((RangeValues e) => RangeValues(log(e.start + 1), log(e.end + 1)))
      .toList();
  final fieldNames = fieldNamesForProduct();

  // @override
  // void initState() {
  //   super.initState();
  //     print('initState');
  //   _maxRangeValues = List<RangeValues>.generate(6, (index) => getRange(index));
  //
  //   _currentRangeValues = List<RangeValues>.generate(6, (index) => getRange(index));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.0,
                  width: 500.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        filter = text;
                      });
                    },
                    style: Theme.of(context).textTheme.headline2,
                    controller: mySearchController,
                    decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.headline3,
                        border: OutlineInputBorder(),
                        hintText: 'Search'),
                  ),
                ),
                Container(
                  height: 80.0,
                  width: 210.0,
                  padding: EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewCompoundProductPage(
                                title: 'Create compound product',
                                list: order,
                                account: widget.account,
                              )));
                    },
                    child: Text('View Product'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100.0,
                    ),
                    Column(children: createRangeSliderList()),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: createListViewOfProduct(
                        context,
                        widget.productListBase,
                        filter,
                        _currentRangeValues
                            .map((RangeValues e) =>
                            RangeValues(exp(e.start) - 1, exp(e.end) - 0.99))
                            .toList(),
                        order),
                  ),
                ),
              ],
            ),
          ],
        ),
        // child: createTable(context),
        // child: createListViewOfProduct(context),
      ),
    );
  }

  @override
  void dispose() {
    mySearchController.dispose();
    super.dispose();
  }

  List<Widget> createRangeSliderList() {
    return List<Widget>.generate(fieldNames.length - 1, (index) {
      return Column(
        children: [
          Container(
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Text(fieldNames[index + 1],
                  style: Theme.of(context).textTheme.headline4),
              Container(
                child: RangeSlider(
                  onChanged: (range) {
                    setState(() {
                      _currentRangeValues[index] = range;
                    });
                  },
                  values: _currentRangeValues[index],
                  min: _maxRangeValues[index].start,
                  max: _maxRangeValues[index].end,
                  divisions: (exp(_maxRangeValues[index].end) -
                      exp(_maxRangeValues[index].start))
                      .round() *
                      value,
                  labels: RangeLabels(
                    (exp(_currentRangeValues[index].start) - 1)
                        .toStringAsFixed(2),
                    (exp(_currentRangeValues[index].end) - 1)
                        .toStringAsFixed(2),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: 40.0,
          )
        ],
      );
    });
  }

  RangeValues getRange(int index) {
    double minV = 1000000;
    double maxV = -100000;

    for (var item in widget.productListBase) {
      switch (fieldNames[index + 1]) {
        case 'rating':
          {
            minV = min(minV, item.rating);
            maxV = max(maxV, item.rating);
          }
          break;
        case 'calories':
          {
            minV = min(minV, item.calories);
            maxV = max(maxV, item.calories);
          }
          break;
        case 'protein':
          {
            minV = min(minV, item.protein);
            maxV = max(maxV, item.protein);
          }
          break;
        case 'fat':
          {
            minV = min(minV, item.fat);
            maxV = max(maxV, item.fat);
          }
          break;
        case 'sodium':
          {
            minV = min(minV, item.sodium);
            maxV = max(maxV, item.sodium);
          }
          break;
        case 'price':
          {
            minV = min(minV, item.price);
            maxV = max(maxV, item.price);
          }
          break;
      }
    }

    return RangeValues(minV, maxV);
  }
}
