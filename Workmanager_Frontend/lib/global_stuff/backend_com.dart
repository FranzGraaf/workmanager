import 'dart:convert';
import 'package:http/http.dart' as http;

class Backend_Com {
  static String _be_url = "http://127.0.0.1:5000";

  Future getdata(String url) async {
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Future postdata(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data);
    return json.decode(response.body);
  }

  Future<double> addieren(double zahl_1, double zahl_2) async {
    String url = _be_url + "/addieren";
    Map<String, dynamic> data = {"zahl_1": zahl_1, "zahl_2": zahl_2};
    double _response =
        (await Backend_Com().postdata(url, jsonEncode(data)))["summe"];
    return _response;
  }
}
