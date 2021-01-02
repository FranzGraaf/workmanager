import 'package:intl/intl.dart';

class DB_User {
  String id;
  bool verified;
  DateTime creation_time;
  List<Map<String, dynamic>> tasks_open;
  List<Map<String, dynamic>> tasks_done;

  DB_User({
    this.id,
    this.verified,
    this.creation_time,
    this.tasks_open,
    this.tasks_done,
  });

  DB_User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    verified = json['Verified'];
    if (json['Creation_Time'] != null) {
      creation_time =
          DateFormat("yyyy.MM.dd hh:mm:ss").parse(json['Creation_Time']);
    }
    tasks_open = [];
    if (json['Tasks_Open'] != null) {
      List<Map<String, dynamic>> list = json['Tasks_Open'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        tasks_open.add(_temp);
      });
    }
    tasks_done = [];
    if (json['Tasks_Done'] != null) {
      List<Map<String, dynamic>> list = json['Tasks_Done'];
      Map<String, dynamic> _temp = {};
      list.forEach((element) {
        _temp = {};
        element.forEach((key, value) {
          _temp[key] = value;
        });
        tasks_done.add(_temp);
      });
    }
  }
}
