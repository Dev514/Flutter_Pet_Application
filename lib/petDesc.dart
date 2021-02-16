import 'package:flutter/material.dart';
import 'package:pet_app/Productmodel.dart';
import 'package:pet_app/cart.dart';
import 'package:pet_app/configuration.dart';

class petDesc extends StatelessWidget {
  final Product value;

  petDesc({Key key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.orange[200],
                  child: Align(
                      child: Image.asset('assets/images/${value.name}.png')),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Center(
                    child: Center(
                      child: Text(
                        '${value.description}',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: shadowlist,
              ),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    '${value.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    '${value.price}\$',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 40, right: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange),
                        child: Center(
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        Colors.deepOrange;

                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new cart(
                              value: Product(
                            value.category,
                            value.name,
                            value.description,
                            value.price,
                            value.key,
                          )),
                        );
                        Navigator.of(context).push(route);
                      },
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
