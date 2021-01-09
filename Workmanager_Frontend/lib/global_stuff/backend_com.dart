import 'dart:convert';
import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:http/http.dart' as http;
import 'package:cooky/cooky.dart' as cookie;

class Backend_Com {
  static String _be_url = "http://127.0.0.1:5000";

  Future getdata(String url) async {
    refresh_id_token();
    var _header = {"id_token": cookie.get("id_token")};
    http.Response response = await http.get(url, headers: _header);
    return json.decode(response.body);
  }

  Future postdata(String url, dynamic data) async {
    refresh_id_token();
    var _header = {"id_token": cookie.get("id_token")};
    http.Response response = await http.post(url, body: data, headers: _header);
    return json.decode(response.body);
  }

  Future<double> addieren(double zahl_1, double zahl_2) async {
    String url = _be_url + "/addieren";
    Map<String, dynamic> data = {"zahl_1": zahl_1, "zahl_2": zahl_2};
    double _response =
        (await Backend_Com().postdata(url, jsonEncode(data)))["summe"];
    return _response;
  }

  Future<bool> increment_counter() async {
    String url = _be_url + "/increment_counter";
    bool _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    return _response;
  }

  Future<bool> create_user() async {
    String url = _be_url + "/create_user";
    bool _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    return _response;
  }

  Future<DB_User> get_user() async {
    String url = _be_url + "/get_user";
    var _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    return DB_User.fromJson(jsonDecode(_response));
  }

  Future<bool> task_to_open(Map<String, dynamic> task) async {
    String url = _be_url + "/task_to_open";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          task,
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> change_task_open(
      Map<String, dynamic> old_task, Map<String, dynamic> new_task) async {
    String url = _be_url + "/change_task_open";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          [old_task, new_task],
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> delete_open_task(Map<String, dynamic> task) async {
    String url = _be_url + "/delete_open_task";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          task,
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> task_to_done(Map<String, dynamic> task) async {
    String url = _be_url + "/task_to_done";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          task,
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> change_task_done(
      Map<String, dynamic> old_task, Map<String, dynamic> new_task) async {
    String url = _be_url + "/change_task_done";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          [old_task, new_task],
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> delete_done_task(Map<String, dynamic> task) async {
    String url = _be_url + "/delete_done_task";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          task,
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future<bool> change_user_data(String name, dynamic value) async {
    String url = _be_url + "/change_user_data";
    bool _response = (await Backend_Com().postdata(
        url,
        jsonEncode(
          {"name": name, "value": value},
          toEncodable: (nonEncodable) {
            return nonEncodable.toString();
          },
        )));
    return _response;
  }

  Future sort_open_tasks() async {
    String url = _be_url + "/sort_open_tasks";
    var _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    print(_response);
    return _response;
  }

  //TODO: sort the users tasks_open list

  //TODO: Add to Monday_Time / Monday_Time / Tuesday_Time / Wednesday_Time / Thursday_Time / Friday_Time / Saturday_Time / Sunday_Time
  //TODO: Remove from Monday_Time / Monday_Time / Tuesday_Time / Wednesday_Time / Thursday_Time / Friday_Time / Saturday_Time / Sunday_Time

}
