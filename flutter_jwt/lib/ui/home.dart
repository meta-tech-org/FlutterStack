import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/components/WebWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;
import 'package:flutter_jwt/main.dart';
import 'package:flutter_jwt/utils/constants.dart';
import 'package:universal_html/html.dart' show window;

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
