import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_textinput_v1.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cooky/cooky.dart' as cookie;

class Login extends StatefulWidget {
  static const String route = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _e_mail = "a.a@a.de"; // TODO: empty string "", value just for testing
  String _passwort = "123456"; // TODO: empty string "", value just for testing
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return SizedBox(
      width: 310,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Own_Textinput_V1(
                init_text: _e_mail,
                label: "E-Mail",
                on_changed: (value) {
                  _e_mail = value;
                },
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    "noch kein Profil?",
                    style: TextStyle(fontSize: 12),
                  ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Own_Textinput_V1(
                init_text: _passwort,
                label: "Passwort",
                obscure: true,
                on_changed: (value) {
                  _passwort = value;
                },
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Passwort vergessen?",
                    style: TextStyle(fontSize: 12),
                  ))
            ],
          ),
          _loading
              ? CircularProgressIndicator()
              : RaisedButton(
                  color: Colors.orangeAccent,
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    try {
                      String _id_token =
                          await signInWithEmailPassword(_e_mail, _passwort);
                      print(_id_token);
                      //TODO: get userdata via backend and save to global_user_data
                      global_usertype = Usertype.user;
                      Navigator.of(context).pushNamed(Homepage.route);
                    } catch (e) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Eingaben überprüfen.",
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(milliseconds: 1500),
                      ));
                    }
                    setState(() {
                      _loading = false;
                    });
                  },
                  child: Text("Login"),
                )
        ],
      ),
    );
  }
}
