import 'package:flutter/material.dart';
import 'package:flutter_jwt/utils/constants.dart';
import 'package:http/http.dart' as http;

class WebWidget extends StatefulWidget {
  const WebWidget({Key key, this.builder}) : super(key: key);

  final AsyncWidgetBuilder builder;

  @override
  _WebWidgetState createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget> {

  Widget test(String data) {
    return Column(children: <Widget>[
      Text("here's the data:"),
      Text(data),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.read(Uri.parse('$SERVER_IP/WeatherForecast/getAuth'),
            headers: {"Authorization": "Bearer JWT"}),
        builder: (context, snapshot) => snapshot.hasData
            ? test(snapshot.data)
            : snapshot.hasError
                ? Text("An error occurred")
                : CircularProgressIndicator());
  }
}
