import 'package:flutter/material.dart';

class Own_Textinput_V1 extends StatefulWidget {
  bool obscure;
  String label;
  String hint_text;
  bool enabled;
  bool autofocus;
  Function(String value) on_changed;
  String init_text;
  int max_lines;
  Own_Textinput_V1(
      {this.max_lines = 1,
      this.init_text = "",
      this.enabled = true,
      this.autofocus = false,
      this.label,
      this.hint_text,
      this.on_changed,
      this.obscure = false});
  @override
  _Own_Textinput_V1State createState() => _Own_Textinput_V1State();
}

class _Own_Textinput_V1State extends State<Own_Textinput_V1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.max_lines,
      initialValue: widget.init_text,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint_text,
        labelText: widget.label,
      ),
      onChanged: (value) {
        widget.on_changed(value);
      },
    );
  }
}
