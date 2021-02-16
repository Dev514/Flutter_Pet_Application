import 'package:flutter/material.dart';
import 'package:pet_app/drawerScreen.dart';
import 'package:pet_app/homeScreen.dart';

class homepage extends StatelessWidget {
  final String role;
  homepage({Key key, @required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(
            role: role,
          ),
          HomeScreen(),
        ],
      ),
    );
  }
}
