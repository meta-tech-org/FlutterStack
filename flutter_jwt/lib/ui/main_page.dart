import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt/components/WebWidget.dart';
import 'package:flutter_jwt/ui/account.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("My Home Screen")),
        body: IndexedStack(children: [
          WebWidget(
              route: "WeatherForecast/getAuth",
              onHasDataWidget: (data) => Column(
                    children: <Widget>[
                      Text("Data", style: TextStyle(fontSize: 30.0)),
                      Text(data),
                    ],
                  )),
          AccountPage()
        ], index: _currentIndex),
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
