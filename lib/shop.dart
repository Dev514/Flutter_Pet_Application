import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/petDesc.dart';

import 'Productmodel.dart';
import 'configuration.dart';

class shop extends StatefulWidget {
  @override
  _shopState createState() => _shopState();
}

class _shopState extends State<shop> {
  String _selectedCategory;

  List<Product> userlist = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference referencedata =
        FirebaseDatabase.instance.reference().child('user/product');
    referencedata.once().then((DataSnapshot datasnapshot) {
      userlist.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for (var key in keys) {
        print(key);
        Product product = new Product(
            values[key]['category'],
            values[key]['name'],
            values[key]['description'],
            values[key]['price'],
            key);

        userlist.add(product);
      }
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: userlist.length == 0
            ? Center(
                child: Text(
                  "No Data available",
                  style: TextStyle(fontSize: 30),
                ),
              )
            : Container(
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: userlist.length,
                    itemBuilder: (_, index) {
                      print(userlist[index].key);
                      return petList(userlist[index].name,
                          userlist[index].price, userlist[index].key, index);
                    })));
  }

  Widget petList(String name, String price, String key, index) {
    return InkWell(
      onTap: () {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new petDesc(
              value: Product(
            userlist[index].category,
            userlist[index].name,
            userlist[index].description,
            userlist[index].price,
            userlist[index].key,
          )),
        );
        Navigator.of(context).push(route);
      },
      child: Container(
        height: 240,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: shadowlist,
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Align(child: Image.asset('assets/images/$name.png')),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 60, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowlist,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Align(
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
