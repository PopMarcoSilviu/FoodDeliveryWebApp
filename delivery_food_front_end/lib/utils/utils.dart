
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'TempProductCreate.dart';

Container getUsernameTextField(myUsernameController) {
  return Container(
    width: 350.0,
    child: TextFormField(
      controller: myUsernameController,
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: "username"),
    ),
  );
}

Container getPasswordTextField(myPasswordController) {
  return Container(
    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
    width: 350.0,
    child: TextFormField(
      controller: myPasswordController,
      obscureText: true,
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: "password"),
    ),
  );
}



Container createTableCell(context, text, style) {
  return Container(
    width: 200.0,
    height: 80.0,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple[200],
      border: Border.all(color: Theme.of(context).primaryColor, width: 0.5),
    ),
    child: Container(child: Text(text, style: style)),
  );
}

Container getRow(context, item, List<MenuItem> order) {
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
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: () {
              order.add(item);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    ]),
  );
}

Container separatorCreate() {
  return Container(width: 1.0, height: 10.0);
}

Container createListViewOfProduct(context, productList, filter, ranges, List<MenuItem> order) {
  List<MenuItem> list = productList;
  var fieldNameList = fieldNamesForProduct();
  list = list
      .where(
          (element) => new RegExp(filter).hasMatch(element.title.toLowerCase()))
      .toList();
  list = list.where((element) => isInRange(element, ranges)).toList();

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
                return getRow(context, list[index], order);
              },
              separatorBuilder: (context, position) {
                return separatorCreate();
              }),
        ),
      ],
    ),
  );
}

bool isInRange(MenuItem product, List<RangeValues> ranges) {
  if (product.rating > ranges[0].end ||
      product.rating < ranges[0].start) {
    // print("Rating: " + ranges[0].end.round().toString() + "   " +ranges[0].start.round().toString() );
    return false;
  }
  if (product.calories > ranges[1].end ||
      product.calories < ranges[1].start) {
    return false;
  }
  if (product.protein > ranges[2].end ||
      product.protein < ranges[2].start) {
    return false;
  }
  if (product.fat > ranges[3].end ||
      product.fat < ranges[3].start) {
    return false;
  }
  if (product.sodium > ranges[4].end ||
      product.sodium < ranges[4].start) {
    return false;
  }
  if (product.price > ranges[5].end||
      product.price < ranges[5].start) {
    // print(ranges[5].end.round().toString() + "  " + ranges[5].start.round().toString());
    return false;
  }

  return true;
}


