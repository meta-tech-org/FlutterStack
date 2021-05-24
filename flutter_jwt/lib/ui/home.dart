import 'package:flutter/material.dart';
import 'package:flutter_jwt/components/WebWidget.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WebWidget(
        route: "WeatherForecast/getAuth",
        onHasDataWidget: (data) => Column(
              children: <Widget>[
                Text("Data", style: TextStyle(fontSize: 30.0)),
                Text(data),
              ],
            ));
  }
}
