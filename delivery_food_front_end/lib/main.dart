
import 'package:delivery_food_front_end/data/MenuItem.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Pages/StartPage.dart';
import 'server.communication/dataService.dart';

Future<void> main() async {

  List<MenuItem> list = await fetchDataBase();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, backgroundColor: Colors.deepPurple[200]),
          headline6: TextStyle(fontSize: 36.0, color: Colors.white),
          headline4: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
          headline2: TextStyle(fontSize: 30.0, color: Colors.black),
          headline3: TextStyle(fontSize: 30.0, color: Colors.grey),
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          button: TextStyle(fontSize: 24.0, color: Colors.white),
          overline: TextStyle(fontSize: 24.0, color: Colors.grey[700]),
        ),
      ),
      home: MyHomePage(title: 'Delivery App'),
    );
  }
}

