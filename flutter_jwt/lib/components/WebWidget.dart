import 'package:flutter/material.dart';
import 'package:flutter_jwt/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';

class WebWidget extends StatefulWidget {
  final Widget Function(dynamic) onHasDataWidget;
  final String route;

  const WebWidget({Key key, this.route, this.onHasDataWidget})
      : super(key: key);

  @override
  _WebWidgetState createState() => _WebWidgetState(route, onHasDataWidget);
}

class _WebWidgetState extends State<WebWidget> {
  final String route;
  final Widget Function(dynamic) onHasDataWidget;

  _WebWidgetState(this.route, this.onHasDataWidget);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.read(Uri.parse('$SERVER_IP/$route'), headers: {
          "Authorization": "Bearer ${context.watch<UserState>().jwtOrEmpty}"
        }),
        builder: (context, snapshot) => snapshot.hasData
            ? onHasDataWidget(snapshot.data)
            : snapshot.hasError
                ? Text("An error occurred")
                : CircularProgressIndicator());
  }
}
