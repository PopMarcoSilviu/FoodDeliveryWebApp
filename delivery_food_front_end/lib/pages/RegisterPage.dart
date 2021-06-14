
import 'package:delivery_food_front_end/data/UserType.dart';
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Utils/utils.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();
  UserType? currentUserType = UserType.CUSTOMER;

  showAlertDialog(BuildContext context, registeredSuccessfully, tooShort) {
    String errorMsg;

    if (tooShort) {
      errorMsg = 'Username and/or password too short';
    } else {
      errorMsg = 'Username already taken';
    }

    Widget okButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text('OK'));
    AlertDialog createdAlert = AlertDialog(
      title: Text(
        'Registration',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Text('Registration complete'),
      actions: [
        okButton,
      ],
    );

    Widget retryButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('retry'));

    Widget backToLogicButton = ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text('back'));

    AlertDialog retryAlert = AlertDialog(
      title: Text('Registration', style: Theme.of(context).textTheme.headline2),
      content: Text(errorMsg),
      actions: [
        retryButton,
        backToLogicButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (tooShort) {
          return retryAlert;
        }

        if (registeredSuccessfully) {
          return createdAlert;
        } else {
          return retryAlert;
        }
      },
    );
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
              height: 100.0,
              width: 100.0,
            ),
            getUsernameTextField(myUsernameController),
            getPasswordTextField(myPasswordController),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
              width: 350.0,
              child: DropdownButton<UserType>(
                value: currentUserType,
                // elevation: 25,
                style: Theme.of(context).textTheme.overline,
                elevation: 6,
                dropdownColor: Colors.deepPurple[200],
                underline: Container(
                  height: 2.5,
                  color: Theme.of(context).primaryColor,
                ),
                items: <UserType>[
                  UserType.CUSTOMER,
                  UserType.ADMIN,
                  UserType.EMPLOYEE
                ].map<DropdownMenuItem<UserType>>((UserType value) {
                  return DropdownMenuItem(
                    child: Container(
                      child: Text(
                          value.toString().substring(value.toString().indexOf('.') + 1),
                      ),
                    ),
                    value: value,

                  ); 
                }).toList(),
                onChanged: (UserType? value) {
                  setState(() {
                    currentUserType = value;
                  });
                },
              ),
            ),
            Container(
              width: 140.0,
              height: 35.0,
              child: ElevatedButton(
                child: Text('Register'),
                onPressed: () async {

                  bool tooShort = (myUsernameController.text.length < 3 ||
                      myPasswordController.text.length < 3);

                  bool validationSuccessful = await
                    checkIfRegistered(myPasswordController.text, myUsernameController.text, currentUserType);


                  if (!tooShort && validationSuccessful)
                  {
                    showAlertDialog(context, false, false);
                  } else {
                    showAlertDialog(context, true, tooShort);

                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    myUsernameController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }
}
