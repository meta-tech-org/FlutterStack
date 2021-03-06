import 'package:flutter/material.dart';
import 'package:flutter_jwt/ui/main_page.dart';
import 'package:flutter_jwt/ui/login.dart';
import 'package:flutter_jwt/utils/storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:provider/provider.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  configureApp();
  runApp(ChangeNotifierProvider(create: (_) => UserState(), child: MyApp(),));
}

final Storage storage = Storage();

class UserState with ChangeNotifier{
  Future<String> jwtOrEmpty() async {
    return storage.read("jwt");
  }
  Future<String> emailOrEmpty() async {
    return storage.read("email");
  }
  Future<String> idOrEmpty() async {
    return storage.read("id");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login' : (context) => MyApp(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/main': (context) => MainPage(),
      },
      home: FutureBuilder(
          future: context.watch<UserState>().jwtOrEmpty(),
          builder: (context, snapshot) {
            // Check snapshot is data is existing
            // If snapshot has not data, the async data call is not finished yet
            if (!snapshot.hasData) return CircularProgressIndicator();

            //  The async data call return no JWT data
            if (snapshot.data == "") {
              // Remove existing key from localStorage
              storage.reset("jwt");
              return LoginPage();
            }

            // Get JWT representation from storage
            var str = snapshot.data;
            var jwt = str.split(".");

            // The token is not in the correct format
            // Normally the JWT is a Base64 encoded string separated by three '.'
            if (jwt.length != 3) {
              // Remove existing 'wrong' key from localStorage
              storage.reset("jwt");
              return LoginPage();
            }

            // Decode JWT data
            var payload = json
                .decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));

            // Check if the lifetime of the token has run out
            if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                .isBefore(DateTime.now())) {
              // Remove existing old key from localStorage
              storage.reset("jwt");
              return LoginPage();
            }

            // The token is valid and is not expired
            return MainPage();
          }),
    );
  }
}
