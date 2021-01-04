import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_textinput_v1.dart';
import 'package:flutter/material.dart';

enum Profile_Change_Data { email, password }

class Main_Profile extends StatefulWidget {
  static const String route = '/main_profile';
  @override
  _Main_ProfileState createState() => _Main_ProfileState();
}

class _Main_ProfileState extends State<Main_Profile> {
  Future<void> _change_data(
      Profile_Change_Data pcd, BuildContext n_context) async {
    Widget _content() {
      switch (pcd) {
        case Profile_Change_Data.email:
          return Main_Profile_Change_Email(
            context: n_context,
          );
        case Profile_Change_Data.password:
          return Main_Profile_Change_Password(
            context: n_context,
          );
        default:
          return Container();
      }
    }

    return showGeneralDialog<void>(
        pageBuilder: (context, anim1, anim2) {
          return Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.black)),
                  width: 300,
                  height: 300,
                  child: _content(),
                ),
              )
            ],
          );
        },
        context: context,
        barrierDismissible: true, // true = user can tab barrier to close
        barrierLabel: "barrierLabel",
        barrierColor: Colors.grey.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 250),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
            scale: anim1.value,
            child: child,
          );
        }).then((value) {
      Scaffold.of(n_context).removeCurrentSnackBar();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Column(
      children: [
        SizedBox(
          height: _on_mobile ? 70 : 10,
        ),
        SizedBox(
          width: _screen_size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 250,
                      child: Own_Textinput_V1(
                        init_text: auth_firebase.currentUser.email,
                        label: "E-Mail",
                        enabled: false,
                      )),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _change_data(Profile_Change_Data.email, context);
                      })
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 250,
                      child: Own_Textinput_V1(
                        init_text: "xxxxxxxxx",
                        label: "Passwort",
                        enabled: false,
                        obscure: true,
                      )),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _change_data(Profile_Change_Data.password, context);
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Main_Profile_Change_Email extends StatefulWidget {
  BuildContext context;
  Main_Profile_Change_Email({this.context});
  @override
  _Main_Profile_Change_EmailState createState() =>
      _Main_Profile_Change_EmailState();
}

class _Main_Profile_Change_EmailState extends State<Main_Profile_Change_Email> {
  String _new_email = auth_firebase.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                init_text: auth_firebase.currentUser.email,
                label: "neue E-Mail",
                enabled: true,
                on_changed: (value) {
                  _new_email = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  try {
                    await auth_firebase.currentUser.updateEmail(_new_email);
                    Navigator.of(context).pop();
                  } catch (e) {
                    Scaffold.of(widget.context).showSnackBar(SnackBar(
                      content: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }
                },
                child: Text("Ändern"),
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Abbrechen"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Main_Profile_Change_Password extends StatefulWidget {
  BuildContext context;
  Main_Profile_Change_Password({this.context});
  @override
  _Main_Profile_Change_PasswordState createState() =>
      _Main_Profile_Change_PasswordState();
}

class _Main_Profile_Change_PasswordState
    extends State<Main_Profile_Change_Password> {
  String _passwort_0 = "";
  String _passwort_1 = "";

  bool _check_input() {
    Scaffold.of(widget.context).removeCurrentSnackBar();
    if (_passwort_0.length < 6) {
      Scaffold.of(widget.context).showSnackBar(SnackBar(
        content: Text(
          "Das Passwort ist zu kurz.",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      return false;
    }
    if (_passwort_0 != _passwort_1) {
      Scaffold.of(widget.context).showSnackBar(SnackBar(
        content: Text(
          "Die Passwörter sind nicht identisch.",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                obscure: true,
                label: "neues Passwort",
                enabled: true,
                on_changed: (value) {
                  _passwort_0 = value;
                },
              )),
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                obscure: true,
                label: "Passwort bestätigen",
                enabled: true,
                on_changed: (value) {
                  _passwort_1 = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  try {
                    if (_check_input()) {
                      await auth_firebase.currentUser
                          .updatePassword(_passwort_0);
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    Scaffold.of(widget.context).removeCurrentSnackBar();
                    Scaffold.of(widget.context).showSnackBar(SnackBar(
                      content: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }
                },
                child: Text("Ändern"),
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Abbrechen"),
              )
            ],
          )
        ],
      ),
    );
  }
}
