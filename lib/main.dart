import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wheather app',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: kPrimaryColor),
      home: HomeScreen(),
    );
  }
}
