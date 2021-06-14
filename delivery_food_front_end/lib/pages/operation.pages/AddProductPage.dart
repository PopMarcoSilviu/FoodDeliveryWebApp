import 'package:delivery_food_front_end/Utils/TempProductCreate.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage(this.title);

  final String title;

  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<String> fieldNames = fieldNamesForProduct();
  List<TextEditingController> controllerList =
      List<TextEditingController>.generate(
          7, (index) => TextEditingController());
  var listValues = List<Object>.generate(7, (index) => index == 0 ? "0" : 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 800.0,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 400.0,
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (text) {
                            if (index == 0) {
                              if (text.length < 3) return;

                              listValues[index] = text;
                            } else {
                              if (num.tryParse(text) == null) {
                                listValues[index] = -1;
                                return;
                              }
                              listValues[index] = double.parse(text);
                            }
                          },
                          style: Theme.of(context).textTheme.headline2,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.headline3,
                            border: OutlineInputBorder(),
                            hintText: fieldNames[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, position) {
                      return Container(
                        height: 10.0,
                      );
                    },
                    itemCount: fieldNames.length),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      for (int i = 1; i < listValues.length; i++) {
                        if (listValues[i] == -1) {
                          showAlertDialog(context);
                          return;
                        }
                      }

                      MenuItem menuItem = MenuItem(
                          title: listValues[0] as String,
                          rating: listValues[1] as double,
                          calories: listValues[2] as double,
                          protein: listValues[3] as double,
                          fat: listValues[4] as double,
                          sodium: listValues[5] as double,
                          price: listValues[6] as double);

                      postBaseProduct(menuItem);

                    },
                    child: Text(
                      ' ADD ',
                      style: Theme.of(context).textTheme.headline6,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'OK',
        style: Theme.of(context).textTheme.button,
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Error'),
      content: Text(
        'Cannot add this',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [
        okButton,
      ],
    );
  }
}
