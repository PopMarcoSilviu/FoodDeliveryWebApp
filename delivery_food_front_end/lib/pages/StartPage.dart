

import 'package:delivery_food_front_end/Pages/EmployeePage.dart';
import 'package:delivery_food_front_end/data/Account.dart';
import 'package:delivery_food_front_end/data/MenuItem.dart';
import 'package:delivery_food_front_end/data/UserType.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../server.communication/Sockets.dart';
import '../Utils/utils.dart';
import 'AdminPage.dart';
import 'ClientPage.dart';
import 'RegisterPage.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();
  late List<MenuItem> baseMenuItems;
  late List<MenuItem> compositeMenuItems;


  @override
  void initState() {
    super.initState();
    stompClient.activate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
            future: Future.wait([
              fetchDataComposite(),
              fetchDataBase(),
            ]),
            builder: (context, AsyncSnapshot<List<List<Object>>> snapshot) {
              if (snapshot.hasData) {
                //Success
                baseMenuItems = snapshot.data![1].cast<MenuItem>();
                compositeMenuItems = snapshot.data![0].cast<MenuItem>();

                return createMainColumn(context, myUsernameController,
                    myPasswordController, baseMenuItems)                  ;
              }
              if (snapshot.hasError) {
                //Error
              }

              return LinearProgressIndicator(value: null);
            }),
      ),
    );
  }

  @override
  void dispose() {
    myPasswordController.dispose();
    myUsernameController.dispose();
    super.dispose();
  }
}

Column createMainColumn(context, TextEditingController myUsernameController,  TextEditingController myPasswordController,
    productList) {
  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'));
    AlertDialog alert = AlertDialog(
      title: Text(
        'Error',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Text('Cannot find matching username and password'),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
        height: 150.0,
        child: Text(
          'Login page',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      getUsernameTextField(myUsernameController),
      getPasswordTextField(myPasswordController),
      Container(
        width: 160.0,
        height: 35.0,
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () async {
            Account? account = await checkIfHasAccount(myUsernameController.text, myPasswordController.text);


              if(account == null)
                {
                  showAlertDialog(context);
                  return;
                }

            switch (account.userType) {
              case UserType.CUSTOMER:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientPage(
                              title: 'Search and order',
                              productListBase: productList, account: account,)));
                  return;
                }
              case UserType.ADMIN:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminPage(
                            account: account,
                            title: 'Admin page',
                            list: productList,
                          )));
                  return;
                }

              case UserType.EMPLOYEE:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>
                    EmployeePage(title: 'Employee page', stream: streamController.stream,))
                  );

                  break;
                }
            }

          },
        ),
      ),
      Container(
        width: 140.0,
        height: 14.0,
      ),
      Container(
        width: 160.0,
        height: 35.0,
        child: ElevatedButton(
          child: Text('Register'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterPage(title: 'Register')));
          },
        ),
      )
    ],
  );
}
