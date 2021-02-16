import 'package:flutter/material.dart';
import 'package:pet_app/Productmodel.dart';
import 'package:pet_app/admin.dart';
import 'package:pet_app/configuration.dart';
import 'package:pet_app/petDesc.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference referencedata =
      FirebaseDatabase.instance.reference().child('user/product');
  _HomeScreenState() {
    referencedata.once().then((DataSnapshot datasnapshot) {
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for (var key in keys) {
        print(key);
        print(userproductlist.length);
        Product product = new Product(
            values[key]['category'],
            values[key]['name'],
            values[key]['description'],
            values[key]['price'],
            key);

        userproductlist.add(product);
      }
      setState(() {});
    });
  }
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  List<Product> userproductlist = [];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
        color: Colors.grey[200],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          })
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  Column(
                    children: [
                      Text("Location"),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          Text("India"),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text("Search pet to Buy "),
                  Icon(Icons.settings),
                ],
              ),
            ),
            Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowlist,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            image[index]['iconpath'],
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Text(categories[index]['name']),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 500,
              padding: EdgeInsets.all(20),
              child: userproductlist.length == 0
                  ? Center(
                      child: Text(
                        "No Data available",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userproductlist.length,
                      itemBuilder: (_, index) {
                        print(userproductlist[index].key);
                        return petList(
                            userproductlist[index].name,
                            userproductlist[index].price,
                            userproductlist[index].key,
                            index);
                      }),
            )
          ],
        ),
      ),
    );
  }

  Widget petList(String name, String price, String key, index) {
    return InkWell(
      onTap: () {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new petDesc(
              value: Product(
            userproductlist[index].category,
            userproductlist[index].name,
            userproductlist[index].description,
            userproductlist[index].price,
            userproductlist[index].key,
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
                  Align(
                      child: Image.asset(
                    'assets/images/$name.png',
                    width: 260,
                    height: 260,
                  )),
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
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$price\$',
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
