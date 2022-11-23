import 'package:flutter/material.dart';
import 'package:hyjoden/screens/add_water_screen.dart';
import 'package:hyjoden/screens/edit_profile_screen.dart';
import 'package:hyjoden/screens/home_screen.dart';
import 'package:hyjoden/screens/login_screen.dart';
import 'package:hyjoden/screens/register_data_screen.dart';
import 'package:hyjoden/screens/register_screen.dart';
import 'package:hyjoden/screens/summary_screen.dart';
import 'package:hyjoden/screens/reward_screen.dart';
import 'package:hyjoden/screens/profile_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home" : (BuildContext context) => HomeScreen(),
  "/summary" : (BuildContext context) => SummaryScreen(),
  "/login" : (BuildContext context) => LoginScreen(),
  "/register" : (BuildContext context) => RegisterScreen(),
  "/register-data" : (BuildContext context) => RegisterDataScreen(),
  "/add-water" : (BuildContext context) => AddWaterScreen(),
  "/reward" : (BuildContext context) => RewardScreen(),
  "/profile" : (BuildContext context) => ProfileScreen(),
  "/edit-profile" : (BuildContext context) => EditProfileScreen(),
};