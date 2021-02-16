import 'package:flutter/material.dart';
import 'package:pet_app/admin.dart';
import 'package:pet_app/login_form.dart';
import 'package:pet_app/superadmin.dart';

class DrawerScreen extends StatefulWidget {
  final String role;
  DrawerScreen({Key key, @required this.role}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.only(bottom: 30, left: 10, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "Devendra Yadav",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.role == 'Admin')
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.admin_panel_settings_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'Add Pet',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => admin()));
                    },
                  ),
                SizedBox(
                  height: 10,
                ),
                if (widget.role == 'Superadmin')
                  GestureDetector(
                    child: Row(children: [
                      Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                      ),
                      Text(
                        'Approve Pet',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => superadmin()));
                    },
                  ),
                SizedBox(
                  height: 10,
                ),
                if (widget.role == 'User')
                  Row(
                    children: [
                      Icon(
                        Icons.shop,
                        color: Colors.white,
                      ),
                      Text(
                        'Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Settings",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Text(
                  "Log out",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login_form()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
