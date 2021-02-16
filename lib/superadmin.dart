import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pet_app/Productmodel.dart';

import 'configuration.dart';

class superadmin extends StatefulWidget {
  @override
  _superadminState createState() => _superadminState();
}

class _superadminState extends State<superadmin> {
  List<String> category = ['Cat', 'Dog', 'Parrot', 'Rabbit', 'Horse'];
  String _selectedCategory;

  List<Product> productlist = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference referencedata =
        FirebaseDatabase.instance.reference().child('admin/product');
    referencedata.once().then((DataSnapshot datasnapshot) {
      productlist.clear();
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

        productlist.add(product);
      }
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: productlist.length == 0
            ? Center(
                child: Text(
                  "No Data available",
                  style: TextStyle(fontSize: 30),
                ),
              )
            : ListView.builder(
                itemCount: productlist.length,
                itemBuilder: (_, index) {
                  print(productlist[index].key);
                  return Cards(
                      productlist[index].name,
                      productlist[index].description,
                      productlist[index].category,
                      productlist[index].price,
                      productlist[index].key);
                }));
  }

  Widget Cards(name, description, pcategory, price, key) {
    TextEditingController petname = TextEditingController()..text = name;
    TextEditingController petdesc = TextEditingController()..text = description;
    TextEditingController petprice = TextEditingController()..text = price;

    return Card(
      margin: EdgeInsets.all(25),
      color: Colors.orange,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            imagefield(name),
            SizedBox(
              height: 10,
            ),
            nameTextfield(petname),
            SizedBox(
              height: 10,
            ),
            descTextfield(petdesc),
            SizedBox(
              height: 10,
            ),
            priceTextfield(petprice),
            SizedBox(
              height: 10,
            ),
            button(key, petname, petdesc, petprice, pcategory),
          ],
        ),
      ),
    );
  }

  Widget imagefield(String name) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.orange,
                child: ClipOval(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/$name.png'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nameTextfield(TextEditingController petname) {
    return TextFormField(
        controller: petname,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.edit,
            color: Colors.orange,
          ),
          labelText: "Pet Name",
          hintText: "ABC",
        ));
  }

  Widget descTextfield(TextEditingController petdesc) {
    return TextFormField(
        controller: petdesc,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.edit,
            color: Colors.orange,
          ),
          labelText: "Pet Description",
          hintText: "Description",
        ));
  }

  Widget priceTextfield(TextEditingController petprice) {
    return TextFormField(
        controller: petprice,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.edit,
            color: Colors.orange,
          ),
          labelText: "Pet Price",
          hintText: "Price in dollar",
        ));
  }

  Widget categoryField() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            icon: Icon(
              Icons.category,
              color: Colors.orange,
            ),
            focusColor: Colors.deepOrange,
            hint: Text('Please choose a Category'),
            value: _selectedCategory,
            items: category.map(
              (location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              },
            ).toList(),
            onChanged: (location) {
              setState(() {
                _selectedCategory = location;
              });
            }),
      ),
    );
  }

  Widget button(
      String key,
      TextEditingController petname,
      TextEditingController petdesc,
      TextEditingController petprice,
      pcategory) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                child: Container(
                  height: 55,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                  child: Center(
                    child: Text(
                      "Approve",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  final upref = FirebaseDatabase.instance
                      .reference()
                      .child('user/product');
                  print(key);
                  upref.push().child('').set({
                    'name': petname.text,
                    'description': petdesc.text,
                    'category': pcategory,
                    'price': petprice.text,
                  });

                  final reref = FirebaseDatabase.instance
                      .reference()
                      .child('admin/product');
                  reref.child(key).remove();
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              InkWell(
                child: Container(
                  height: 55,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                  child: Center(
                    child: Text(
                      "Reject",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  final upref = FirebaseDatabase.instance
                      .reference()
                      .child('admin/product');
                  upref.child(key).remove();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
