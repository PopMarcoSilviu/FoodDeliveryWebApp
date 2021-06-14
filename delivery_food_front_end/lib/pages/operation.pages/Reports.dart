
import 'package:delivery_food_front_end/server.communication/dataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  Reports({Key? key, required this.title}) : super(key: key);

  final String title;

  _Reports createState() => _Reports();
}

class _Reports extends State<Reports> {

  String startHour = '';
  String finishHour = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () async {
                      RegExp regExp = RegExp('[0-9]+:[0-9]+');

                      var t =await showTimePicker(
                          cancelText: '',
                          context: context,
                          initialTime: TimeOfDay(hour: 0, minute: 0));

                      RegExpMatch? match = regExp.firstMatch(t.toString());
                      String result = match![0].toString();

                      setState(() {
                        startHour = result;
                      });
                    },
                    child: Text('Select start hour  ' + startHour ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () async {
                    RegExp regExp = RegExp('[0-9]+:[0-9]+');

                    var t =await showTimePicker(
                        cancelText: '',
                        context: context,
                        initialTime: TimeOfDay(hour: 0, minute: 0));

                    RegExpMatch? match = regExp.firstMatch(t.toString());
                    String result = match![0].toString();

                    setState(() {
                      finishHour = result;
                    });
                  },
                  child: Text('Select finish hour  ' + finishHour ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: ()  {
                      reportGenerate(startHour, finishHour);
                  },
                  child: Text('Create report'),
                ),
              ),

            ],
          ),

        ));
  }
}


