import 'dart:convert';

import 'package:delivery_food_front_end/data/Account.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_food_front_end/data/MenuItem.dart';

import '../data/UserType.dart';

Future<List<MenuItem>> fetchDataBase() async {
  final response =
  await http.get(Uri.http("localhost:8080", "initialDataBase"));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List).map((p) => MenuItem.fromJson(p)).toList();
  }
  throw Exception('Failed to load product data base');
}

Future<List<MenuItem>> fetchDataComposite() async {
  final response =
  await http.get(Uri.http("localhost:8080", 'initialDataComposite'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List).map((p) => MenuItem.fromJson(p)).toList();
  }
  throw Exception('Failed to load product data composite');
}

void postOrderData(int clientID, List<MenuItem> list) async {
  Map<String, dynamic> map = {
    'products': list.map((e) => e.toJson()).toList(),
    'clientID': clientID,
  };

  final response = await http.post(Uri.http("localhost:8080", 'orderPost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map));
}

void postBaseProduct(MenuItem baseProduct) async
{
    Map<String, dynamic> map=  baseProduct.toJson();

    final response = await http.post(Uri.http('localhost:8080', 'addProductBase'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map),
    );
}

void deletePostItem(String name) async
{
  final response = await http.post(Uri.http('localhost:8080', 'deletePostItem'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(name)
  );
}

void modifyMenuItem(MenuItem oldItem, MenuItem newItem) async
{

  Map<String, dynamic> map =
  {
    'old' : oldItem,
    'new': newItem,
  };

  final response = await http.post(Uri.http('localhost:8080', 'modifyProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
  );
}

Future<void> createCompoundProduct(List<MenuItem> list, String name , double price)
async {
  Map<String, dynamic> map =
  {
    'list': list,
    'name': name,
    'price': price
  };

  final response = await http.post(Uri.http('localhost:8080', 'createCompoundProduct'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );
}

void importFromCsv() async
{
  final response = await http.get(Uri.http('localhost:8080', 'importFromCsv'));
}

void reportGenerate(String start, String finish) async
{

  Map<String, dynamic> map =
      {
        'start':start,
        'finish':finish,
      };

  final response = await http.post(Uri.http('localhost:8080', 'reportTime'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );
}

Future<bool> checkIfRegistered(String password, String username,
    UserType? userType) async {

  Map<String, dynamic> map = {
    'username': username,
    'password': password,
    'userType': userType.toString()
  };

  final response = await http.post(
    Uri.http('localhost:8080', 'checkForRegistration'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return responseJson;
  }

  throw Exception('Failed to check if the user is already registered');
}

Future<Account?> checkIfHasAccount(String username, String password) async {
  Map<String, dynamic> map = {
    'username': username,
    'password': password,
  };

  final response = await http.post(Uri.http('localhost:8080', 'checkForLogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );

  if(response.statusCode == 200)
    {
    if(response.body.isEmpty)
        {
          return null;
        }

      var responseJson = json.decode(response.body);
      return Account.fromJson(responseJson);
    }

  throw Exception('Failed to check if the user can log in');
}

