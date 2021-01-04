import 'package:flutter/material.dart';

class Impressum extends StatefulWidget {
  static const String route = '/impressum';
  @override
  _ImpressumState createState() => _ImpressumState();
}

class _ImpressumState extends State<Impressum> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Impressum"));
  }
}
