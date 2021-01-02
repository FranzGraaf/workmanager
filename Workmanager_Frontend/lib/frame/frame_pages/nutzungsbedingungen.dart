import 'package:flutter/material.dart';

class Nutzungsbedingungen extends StatefulWidget {
  static const String route = '/nutzungsbedingungen';
  @override
  _NutzungsbedingungenState createState() => _NutzungsbedingungenState();
}

class _NutzungsbedingungenState extends State<Nutzungsbedingungen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Nutzungsbedingungen"));
  }
}
