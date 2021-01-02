import 'package:flutter/material.dart';

class About_Us extends StatefulWidget {
  static const String route = '/about_us';
  @override
  _About_UsState createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("About Us"));
  }
}
