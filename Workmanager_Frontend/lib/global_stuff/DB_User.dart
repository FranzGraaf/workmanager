import 'dart:convert';

import 'package:intl/intl.dart';

class DB_User {
  String id;
  bool verified;
  DateTime creation_time;
  List<Map<String, dynamic>> tasks_open;
  List<Map<String, dynamic>> tasks_done;
  List<Map<String, dynamic>> monday_time;
  List<Map<String, dynamic>> tuesday_time;
  List<Map<String, dynamic>> wednesday_time;
  List<Map<String, dynamic>> thursday_time;
  List<Map<String, dynamic>> friday_time;
  List<Map<String, dynamic>> saturday_time;
  List<Map<String, dynamic>> sunday_time;

  DB_User({
    this.id,
    this.verified,
    this.creation_time,
    this.tasks_open,
    this.tasks_done,
    this.monday_time,
    this.tuesday_time,
    this.wednesday_time,
    this.thursday_time,
    this.friday_time,
    this.saturday_time,
    this.sunday_time,
  });

  DB_User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    verified = json['Verified'];
    if (json['Creation_Time'] != null) {
      creation_time =
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['Creation_Time']);
    }
    tasks_open = [];
    if (json['Tasks_Open'] != null && json['Tasks_Open'].length != 0) {
      List<dynamic> list = json['Tasks_Open'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          if (key == "deadline") {
            _temp[key] = DateFormat("yyyy-MM-dd hh:mm:ss").parse(value);
          } else if (key == "duration") {
            _temp[key] = Duration(
                hours: int.parse(value.split(":")[0]),
                minutes: int.parse(value.split(":")[1]));
          } else {
            _temp[key] = value;
          }
        });
        tasks_open.add(_temp);
      });
    }
    tasks_done = [];
    if (json['Tasks_Done'] != null && json['Tasks_Done'].length != 0) {
      List<dynamic> list = json['Tasks_Done'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          if (key == "deadline") {
            _temp[key] = DateFormat("yyyy-MM-dd hh:mm:ss").parse(value);
          } else if (key == "duration") {
            _temp[key] = Duration(
                hours: int.parse(value.split(":")[0]),
                minutes: int.parse(value.split(":")[1]));
          } else {
            _temp[key] = value;
          }
        });
        tasks_done.add(_temp);
      });
    }
    monday_time = [];
    if (json['Monday_Time'] != null && json['Monday_Time'].length != 0) {
      List<dynamic> list = json['Monday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        monday_time.add(_temp);
      });
    }
    tuesday_time = [];
    if (json['Tuesday_Time'] != null && json['Tuesday_Time'].length != 0) {
      List<dynamic> list = json['Tuesday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        tuesday_time.add(_temp);
      });
    }
    wednesday_time = [];
    if (json['Wednesday_Time'] != null && json['Wednesday_Time'].length != 0) {
      List<dynamic> list = json['Wednesday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        wednesday_time.add(_temp);
      });
    }
    thursday_time = [];
    if (json['Thursday_Time'] != null && json['Thursday_Time'].length != 0) {
      List<dynamic> list = json['Thursday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        thursday_time.add(_temp);
      });
    }
    friday_time = [];
    if (json['Friday_Time'] != null && json['Friday_Time'].length != 0) {
      List<dynamic> list = json['Friday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        friday_time.add(_temp);
      });
    }
    saturday_time = [];
    if (json['Saturday_Time'] != null && json['Saturday_Time'].length != 0) {
      List<dynamic> list = json['Saturday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        saturday_time.add(_temp);
      });
    }
    sunday_time = [];
    if (json['Sunday_Time'] != null && json['Sunday_Time'].length != 0) {
      List<dynamic> list = json['Sunday_Time'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        sunday_time.add(_temp);
      });
    }
  }
}
