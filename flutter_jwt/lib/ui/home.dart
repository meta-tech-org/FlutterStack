import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;
import 'package:flutter_jwt/main.dart';
import 'package:flutter_jwt/utils/constants.dart';
import 'package:universal_html/html.dart' show window;

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Row(children: [
        FutureBuilder(
            future: http.read(Uri.parse('$SERVER_IP/data'),
                headers: {"Authorization": jwt}),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: <Widget>[
                      Text("${payload['username']}, here's the data:"),
                      Text(snapshot.data,
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  )
                : snapshot.hasError
                    ? Text("An error occurred")
                    : CircularProgressIndicator()),
        TextButton(
            onPressed: () {
              if (kIsWeb) {
                window.localStorage.remove("csrf");
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
