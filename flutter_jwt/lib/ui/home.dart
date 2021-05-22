import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/components/WebWidget.dart';
import 'package:flutter_jwt/main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("My Home Screen")),
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
      ]),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTabTapped, // new
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
      type: BottomNavigationBarType.fixed,
    ),
  );
}
