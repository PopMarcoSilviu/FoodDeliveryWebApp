import 'dart:math';

import 'package:delivery_food_front_end/Utils/TempProductCreate.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Utils/TempProductCreate.dart';
import '../../Utils/utils.dart';
import '../ClientPage.dart';

class DeleteModifyProductPage extends StatefulWidget {
  DeleteModifyProductPage({Key? key, required this.title, required this.list});

  final List<MenuItem> list;
  final String title;

  _DeleteModifyProductPageState createState() =>
      _DeleteModifyProductPageState();
}

class _DeleteModifyProductPageState extends State<DeleteModifyProductPage> {
  late List<List<bool>> displayValue;

  late List<MenuItem> currentValues;
  late List<String> fieldNames;
  String filter = '';
  late String toDeleteName;
  late MenuItem toModify;
  late MenuItem newMenuItem ;
  final mySearchController = TextEditingController();

  late List<RangeValues> _currentRangeValues =
      List<RangeValues>.generate(6, (index) => getRange(index))
          .map((RangeValues e) => RangeValues(log(e.start + 1), log(e.end + 1)))
          .toList();

  late List<RangeValues> _maxRangeValues =
      List<RangeValues>.generate(6, (index) => getRange(index))
          .map((RangeValues e) => RangeValues(log(e.start + 1), log(e.end + 1)))
          .toList();

  @override
  void initState() {
    super.initState();
    fieldNames = fieldNamesForProduct();
    currentValues = List<MenuItem>.from(widget.list);
    displayValue = List<List<bool>>.generate(
        widget.list.length, (index) => List<bool>.generate(7, (index) => true));
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
              height: 150.0,
              width: 500.0,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: TextFormField(
                onChanged: (text) {
                  setState(() {
                    filter = text;
                    currentValues = widget.list
                        .where((element) => new RegExp(filter)
                            .hasMatch(element.title.toLowerCase()))
                        .toList();
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
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90.0,
                    ),
                    Column(children: createRangeSliderList()),
                  ],
                ),
                Container(
                  height: 730,
                  width: 1480,
                  child: RawScrollbar(
                    thumbColor: Theme.of(context).primaryColor,
                    radius: Radius.circular(6),
                    isAlwaysShown: true,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return getElement(index);
                        },
                        separatorBuilder: (context, position) {
                          return Container(
                            height: 5.0,
                          );
                        },
                        itemCount: currentValues.length),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getElement(index) {
    List<String> fieldNames = fieldNamesForProduct();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 3,
              offset: Offset(2, 3),
            ),
          ],
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            Row(
              children: [
                getGestureDetector(
                    currentValues[index].title, fieldNames[0], index, 0),
                getGestureDetector(currentValues[index].rating.toString(),
                    fieldNames[1], index, 1),
                getGestureDetector(currentValues[index].calories.toString(),
                    fieldNames[2], index, 2),
                getGestureDetector(currentValues[index].protein.toString(),
                    fieldNames[3], index, 3),
                getGestureDetector(currentValues[index].fat.toString(),
                    fieldNames[4], index, 4),
                getGestureDetector(currentValues[index].sodium.toString(),
                    fieldNames[5], index, 5),
                getGestureDetector(currentValues[index].price.toString(),
                    fieldNames[6], index, 6),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        toDeleteName = currentValues[index].title;
                      });
                      showAlertDialog(context);
                    },
                    child: Icon(
                      Icons.delete_rounded,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      toModify = currentValues[index];
                      newMenuItem  = currentValues[index];
                      showModifyPopUp(context);
                    },
                    child: Icon(Icons.settings),

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showModifyPopUp(context)
  {
    Widget okButton = ElevatedButton(
        onPressed: () {
          modifyMenuItem(toModify, newMenuItem);
          Navigator.pop(context);
        },
        child: Text('OK'));

    Widget cancelButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'));

    AlertDialog alert = AlertDialog(
      title: Text(
        '',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Container(
        child: Column(
                children: getTextFormFields(),
                ),
            ),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialog(context) {
    Widget deleteButton = ElevatedButton(
        onPressed: () {
          deletePostItem(toDeleteName);
          Navigator.pop(context);
        },
        child: Text('Delete'));

    Widget cancelButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'));

    AlertDialog alert = AlertDialog(
      title: Text(
        '',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Text(
        'Are you sure you want to delete this product?',
        style: Theme.of(context).textTheme.headline2,
      ),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget getGestureDetector(String value, String name, index, i) {
    return GestureDetector(
      onTap: () =>
          setState(() => displayValue[index][i] = !displayValue[index][i]),
      child: AnimatedSwitcher(
        duration: Duration(microseconds: 400),
        child: displayValue[index][i]
            ? Container(
                width: i==0?400.0:150.0,
                height: 50.0,
                padding: const EdgeInsets.all(8.0),
                child: (Text(
                  value,
                  style: Theme.of(context).textTheme.headline2,
                )),
              )
            : Container(
                width: i==0?400.0:150.0,
                height: 50.0,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headline2,
                )),
      ),
    );
  }

  RangeValues getRange(int index) {
    double minV = 1000000;
    double maxV = -100000;

    for (var item in widget.list) {
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
                      _currentRangeValues[index] =  range;
                      var ranges =   _currentRangeValues
                          .map((RangeValues e) =>
                          RangeValues(exp(e.start) - 1, exp(e.end) - 0.99))
                          .toList();
                      currentValues = widget.list.where((element) => isInRange(element, ranges)).toList();
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

  List<Widget> getTextFormFields()
  {
    return [

      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[0],
          hintText: toModify.title.toString(),
        ),
        onChanged:(text) {
          newMenuItem.title = text;
        },
      ),


      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[1],
          hintText: toModify.rating.toString(),
        ),
        onChanged:(text) {
          newMenuItem.rating = double.parse(text);
        },
      ),

      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[2],
          hintText: toModify.calories.toString(),
        ),
        onChanged:(text) {
          newMenuItem.calories = double.parse(text);
        },
      ),


      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[3],
          hintText: toModify.protein.toString(),
        ),
        onChanged:(text) {
          newMenuItem.protein = double.parse(text);
        },
      ),


      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[4],
          hintText: toModify.fat.toString(),
        ),
        onChanged:(text) {
          newMenuItem.fat = double.parse(text);
        },
      ),


      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[5],
          hintText: toModify.sodium.toString(),
        ),
        onChanged:(text) {
          newMenuItem.sodium = double.parse(text);
        },
      ),


      TextFormField(
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline3,
          labelText: fieldNames[6],
          hintText: toModify.price.toString(),
        ),
        onChanged:(text) {
          newMenuItem.price = double.parse(text);
        },
      ),

    ];

  }
}

