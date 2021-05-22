import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
              child: Text("Account", style: TextStyle(fontSize: 30.0)),
              alignment: Alignment.center),
          TextButton(
              onPressed: () {
                storage.reset("jwt");
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
