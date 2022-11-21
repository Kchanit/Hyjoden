import 'package:flutter/material.dart';
import 'package:hyjoden/screens/home_screen.dart';
import 'package:hyjoden/screens/login_screen.dart';
import 'package:hyjoden/screens/summary_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home" : (BuildContext context) => HomeScreen(),
  "/summary" : (BuildContext context) => SummaryScreen(),
  "/login" : (BuildContext context) => LoginScreen(),
};