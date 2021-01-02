import 'package:Workmanager_Frontend/frame/frame_pages/about_us.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/datenschutz.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/impressum.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/nutzungsbedingungen.dart';
import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:Workmanager_Frontend/login_register/login.dart';
import 'package:Workmanager_Frontend/login_register/register.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:flutter/material.dart';

class Main_Drawer extends StatefulWidget {
  @override
  _Main_DrawerState createState() => _Main_DrawerState();
}

class _Main_DrawerState extends State<Main_Drawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.orangeAccent.withOpacity(0.9),
      ),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Homepage.route);
                    },
                    child: Text("Home")),
                global_usertype == Usertype.user
                    ? FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Main_Profile.route);
                        },
                        child: Text("Profil"))
                    : Container(),
                global_usertype == Usertype.user
                    ? FlatButton(onPressed: () {}, child: Text("alle Aufgaben"))
                    : Container(),
                global_usertype == Usertype.visitor
                    ? FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.route);
                        },
                        child: Text("Registrieren"))
                    : Container(),
                global_usertype == Usertype.visitor
                    ? FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Login.route);
                        },
                        child: Text("Login"))
                    : Container(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(onPressed: () {}, child: Text("Tag")),
                FlatButton(onPressed: () {}, child: Text("Woche")),
                FlatButton(onPressed: () {}, child: Text("Monat")),
                FlatButton(onPressed: () {}, child: Text("Jahr")),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(About_Us.route);
                    },
                    child: Text("About us")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Impressum.route);
                    },
                    child: Text("Impressum")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Nutzungsbedingungen.route);
                    },
                    child: Text("Nutzungsbedingungen")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Datenschutz.route);
                    },
                    child: Text("Datenschutz")),
                global_usertype == Usertype.user
                    ? FlatButton(
                        onPressed: () {
                          logout();
                          Navigator.of(context).pushNamed(Homepage.route);
                        },
                        child: Text("Abmelden"))
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
