import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/main.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  String _id = "";
  String _email = "";

  _AccountPage() {
    storage.read("id").then((id) => setState(() {
          _id = id;
        }));
    storage.read("email").then((email) => setState(() {
          _email = email;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Align(
                child: Text("Account", style: TextStyle(fontSize: 30.0)),
                alignment: Alignment.center),
            margin: new EdgeInsets.only(bottom: 20),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("Id:",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold)),
                  margin: new EdgeInsets.only(right: 10),
                ),
                Text(_id)
              ],
            ),
            margin: new EdgeInsets.only(bottom: 10),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("Email:",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold)),
                  margin: new EdgeInsets.only(right: 10),
                ),
                Text(_email)
              ],
            ),
            margin: new EdgeInsets.only(bottom: 10),
          ),
          ElevatedButton.icon(
              onPressed: () {
                storage.reset("jwt");
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"))
        ],
      ),
    );
  }
}
