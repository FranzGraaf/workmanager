import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:Workmanager_Frontend/global_stuff/KEYS.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cooky/cooky.dart' as cookie;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await auth_firebase.createUserWithEmailAndPassword(
      email: email, password: password);
  User user = auth_firebase.currentUser;
  String _id_token = await user.getIdToken();
  cookie.set("id_token", _id_token);
  cookie.set("refresh_token", user.refreshToken);
  // create userdata locally after registers
  global_user_data = DB_User(
    id: user.uid,
    verified: user.emailVerified,
    creation_time: DateTime.now(),
    tasks_open: [],
    tasks_done: [],
  );
  return _id_token;
}

Future<String> signInWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  //await Firebase.initializeApp();
  final UserCredential userCredential =
      await auth_firebase.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  final User user = userCredential.user;
  if (user != null) {
    final User currentUser = auth_firebase.currentUser;
    assert(user.uid == currentUser.uid);
    String id_token = await currentUser.getIdToken();
    cookie.set("id_token", id_token);
    cookie.set("refresh_token", user.refreshToken);
    return id_token;
  }
  return null;
}

Future<String> logout() async {
  auth_firebase.signOut();
  cookie.remove("id_token");
  cookie.remove("refresh_token");
  global_user_data = null;
  global_usertype = Usertype.visitor;
  return null;
}

Future<String> refresh_id_token() async {
  // refreshes the session id token with the refresh id token
  if (cookie.get("refresh_token") != null) {
    String _refresh_token = cookie.get("refresh_token");
    String url =
        "https://securetoken.googleapis.com/v1/token?key=" + FIREBASE_API_KEY;
    Map<String, dynamic> data = {
      "grant_type": "refresh_token",
      "refresh_token": _refresh_token
    };
    Map<String, String> _headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    http.Response _response =
        await http.post(url, body: data, headers: _headers);
    String _new_id_token = json.decode(_response.body)["id_token"];
    cookie.set("id_token", _new_id_token);
    return _new_id_token;
  }
  return "";
}
