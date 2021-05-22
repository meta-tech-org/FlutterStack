import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/components/WebWidget.dart';
import 'package:flutter_jwt/main.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Column(children: [
        WebWidget(
            route: "WeatherForecast/getAuth",
            onHasDataWidget: (data) => Column(
                  children: <Widget>[
                    Text("here's the data:"),
                    Text(data),
                  ],
                )),
        TextButton(
            onPressed: () {
              storage.reset("jwt");
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text("Logout"))
      ]));
}
