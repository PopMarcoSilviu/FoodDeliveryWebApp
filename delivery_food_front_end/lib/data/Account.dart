import 'UserType.dart';

class Account {
  final int id;
  final String password;
  final String username;
  final UserType userType;

  const Account(
      {required this.id,
      required this.password,
      required this.username,
      required this.userType});

  factory Account.fromJson(Map<String, dynamic> json) {
    UserType userType = UserType.CUSTOMER;
    switch (json['userType']) {
      case 'ADMIN':
        {
          userType = UserType.ADMIN;
          break;
        }
      case 'CUSTOMER':
        {
          userType = UserType.CUSTOMER;
          break;
        }
      case 'EMPLOYEE':
        {
          userType = UserType.EMPLOYEE;
          break;
        }
    }

    return Account(
        id: json['id'],
        password: json['password'],
        username: json['username'],
        userType: userType);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'password': this.password,
        'username': this.username,
        'UserType': this.userType,
      };
}

