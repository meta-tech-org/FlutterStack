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
  HomePage(this.jwt);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt);

  final String jwt;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Column(children: [
        FutureBuilder(
            future: http.read(Uri.parse('$SERVER_IP/WeatherForecast/getAuth'),
                headers: {"Authorization": "Bearer $jwt"}),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: <Widget>[
                      Text("here's the data:"),
                      Text(snapshot.data),
                      WebWidget()
                    ],
                  )
                : snapshot.hasError
                    ? Text("An error occurred")
                    : CircularProgressIndicator()),
        TextButton(
            onPressed: () {
              if (kIsWeb) {
                window.localStorage.remove("jwt");
              }
              // Mobile: Store in SecureStorage
              else {
                storage.write(key: "jwt", value: null);
              }
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text("Logout"))
      ]));
}
