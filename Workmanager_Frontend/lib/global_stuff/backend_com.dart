import 'dart:convert';
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
    String url = _be_url + "/up";
    bool _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    return _response;
  }

  Future<bool> create_user() async {
    String url = _be_url + "/create_user";
    bool _response = (await Backend_Com().postdata(url, jsonEncode(null)));
    return _response;
  }

  //TODO: Create DB entry for a new user when registered
  //TODO: get complete user data by login token
  //TODO: general change users data
  //TODO: Add a task map to the users tasks_open list
  //TODO: Remove a task map from the users tasks_open list
  //TODO: Add a task map to the users tasks_done list
  //TODO: Remove a task map from the users tasks_done list
  //TODO: sort the users tasks_open list
  //TODO: change task map in users tasks open list
  //(TODO: change task map in users tasks done list)

  //TODO: Add to Monday_Time / Monday_Time / Tuesday_Time / Wednesday_Time / Thursday_Time / Friday_Time / Saturday_Time / Sunday_Time
  //TODO: Change in Monday_Time / Monday_Time / Tuesday_Time / Wednesday_Time / Thursday_Time / Friday_Time / Saturday_Time / Sunday_Time
  //TODO: Remove from Monday_Time / Monday_Time / Tuesday_Time / Wednesday_Time / Thursday_Time / Friday_Time / Saturday_Time / Sunday_Time

}
