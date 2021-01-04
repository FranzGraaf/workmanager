import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double global_mobile_treshold = 700;

String global_active_route = "/";

enum Usertype { visitor, user }
Usertype global_usertype = Usertype.visitor;

DB_User global_user_data;

//Authentication--------------------------------------------------------------------------
final FirebaseAuth auth_firebase = FirebaseAuth.instance;
//Authentication--------------------------------------------------------------------------
