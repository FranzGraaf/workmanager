import 'package:Workmanager_Frontend/global_stuff/backend_com.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workmanager.org',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Material(child: Main()),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  double _zahl_1 = 0;
  double _zahl_2 = 0;
  double _ergebnis = 0;

  void _berechnen() async {
    double _temp = (await Backend_Com().addieren(_zahl_1, _zahl_2));
    setState(() {
      _ergebnis = _temp;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
            child: Text("addieren"),
            onPressed: () {
              _berechnen();
            }),
        SizedBox(
            width: 100,
            height: 50,
            child: TextFormField(
              onChanged: (value) {
                _zahl_1 = double.parse(value);
              },
            )),
        Text("+"),
        SizedBox(
            width: 100,
            height: 50,
            child: TextFormField(
              onChanged: (value) {
                _zahl_2 = double.parse(value);
              },
            )),
        Text("="),
        Text(_ergebnis.toString()),
      ],
    );
  }
}
