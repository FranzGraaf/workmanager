import 'package:Workmanager_Frontend/calender_views/day_calender.dart';
import 'package:Workmanager_Frontend/calender_views/month_calender.dart';
import 'package:Workmanager_Frontend/calender_views/week_calender.dart';
import 'package:Workmanager_Frontend/calender_views/year_calender.dart';
import 'package:Workmanager_Frontend/frame/drawer.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/about_us.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/datenschutz.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/impressum.dart';
import 'package:Workmanager_Frontend/frame/frame_pages/nutzungsbedingungen.dart';
import 'package:Workmanager_Frontend/frame/header_footer.dart';
import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:Workmanager_Frontend/global_stuff/backend_com.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:Workmanager_Frontend/login_register/login.dart';
import 'package:Workmanager_Frontend/login_register/register.dart';
import 'package:Workmanager_Frontend/profile/all_tasks.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:Workmanager_Frontend/router.dart';
import 'package:flutter/material.dart';
import 'package:cooky/cooky.dart' as cookie;

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
      initialRoute: Homepage.route,
      onGenerateRoute: generateRoute,
    );
  }
}

class Main extends StatefulWidget {
  static const String route = '/';
  var arguments;
  Main({this.arguments});
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  void initialise() async {
    print("INITIALISE");
    // sample data start --------------------------------------------------
    /*global_user_data = DB_User(
      creation_time: DateTime.now(),
      tasks_open: [],
      tasks_done: [],
      monday_time: [],
      tuesday_time: [],
      wednesday_time: [],
      thursday_time: [],
      friday_time: [],
      saturday_time: [],
      sunday_time: [],
    );
    global_user_data.tasks_open = [
      {
        "title": "open1",
        "duration": Duration(hours: 2, minutes: 50),
        "deadline": DateTime(2021, 01, 15),
        "description": "kurze Beschreibung",
        "priority": 1
      },
      {
        "title": "open2sfgsgewfsadfwqeasdsdfsdgsfeqreref",
        "duration": Duration(hours: 1, minutes: 30),
        "deadline": DateTime(2021, 01, 12),
        "description": "kurze Beschreibung 2",
        "priority": 0
      },
    ];
    global_user_data.tasks_done = [
      {
        "title": "done1",
        "duration": Duration(hours: 2, minutes: 50),
        "deadline": DateTime(2021, 01, 15),
        "description": "kurze Beschreibung",
        "priority": 1
      },
      {
        "title": "done2",
        "duration": Duration(hours: 1, minutes: 30),
        "deadline": DateTime(2021, 01, 12),
        "description": "kurze Beschreibung 2",
        "priority": 0
      },
    ];
    global_user_data.tuesday_time = [
      {"start": DateTime(0, 0, 0, 8, 30), "end": DateTime(0, 0, 0, 12, 15)}
    ];*/
    // sample data end ----------------------------------------------------
    // check if user is logged in
    if (cookie.get("id_token") != null && cookie.get("id_token") != "") {
      global_usertype = Usertype.user;
      if (global_user_data == null) {
        global_user_data = await Backend_Com().get_user();
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Scaffold(
      drawer: Main_Drawer(),
      body: Stack(
        children: [
          Center(key: UniqueKey(), child: get_main_widget()),
          Header_Footer(),
        ],
      ),
    );
  }
}

Widget get_main_widget() {
  switch (global_active_route) {
    case Homepage.route:
      return Homepage();
    case Register.route:
      return Register();
    case Login.route:
      return Login();
    case Main_Profile.route:
      return Main_Profile();
    case About_Us.route:
      return About_Us();
    case Impressum.route:
      return Impressum();
    case Nutzungsbedingungen.route:
      return Nutzungsbedingungen();
    case Datenschutz.route:
      return Datenschutz();
    case All_Tasks.route:
      return All_Tasks();
    case Day_Calender.route:
      return Day_Calender();
    case Week_Calender.route:
      return Week_Calender();
    case Month_Calender.route:
      return Month_Calender();
    case Year_Calender.route:
      return Year_Calender();
    default:
      return Homepage();
  }
}

/*
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

*/
