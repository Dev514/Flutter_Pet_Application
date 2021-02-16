import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pet_app/homepage.dart';

class login_form extends StatefulWidget {
  @override
  _login_formState createState() => _login_formState();
}

class _login_formState extends State<login_form> {
  List<String> roles = ['User', 'Admin', 'Superadmin'];
  String _selectedCategory;
  final pass = new TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode:
              AutovalidateMode.always, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: categoryField(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.orange,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formkey.currentState.validate() &&
                        pass.text == 'qwerty') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  homepage(role: _selectedCategory)));
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text('New User? Create Account')
            ],
          ),
        ),
      ),
    );
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
            hint: Text('Please choose a Role'),
            value: _selectedCategory,
            items: roles.map(
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
}
