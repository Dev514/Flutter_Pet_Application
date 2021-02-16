import 'package:flutter/material.dart';
import 'package:pet_app/drawerScreen.dart';
import 'package:pet_app/homeScreen.dart';
import 'package:pet_app/login_form.dart';
import 'package:pet_app/shop.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: login_form());
  }
}
