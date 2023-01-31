import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushnotifications/screens/home_page.dart';
import 'package:pushnotifications/screens/second_screen.dart';

class MyRoutes {
 static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case '/':
      return MaterialPageRoute(builder: (_) => const Home());
      case '/second':
      return MaterialPageRoute(builder: (_)=> const Second());
      default:
     throw('no Routes found');
    }
  }
}