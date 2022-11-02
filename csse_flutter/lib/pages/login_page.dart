
// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../common/theme_helper.dart';

import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class Login extends StatefulWidget {
  Login({  Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  Future save() async{
    await http.post(Uri.parse('http://localhost:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, String>{
          "email": user.email,
          "password": user.password,
        }));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }



  User user = User('', '','', '','');
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                 Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.account_box), //let's create a common header widget
            ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                 
              child: Column(
                children:[ 
                  Text(
                      'Welcome',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                  
                  Form(
                  key: _formKey,
                  child: Column(
                  
                    children: [
                      Container(
                       
                        child: TextFormField(
                           decoration: ThemeHelper().textInputDecoration('E-Mail', 'Enter your E-mail'),
                           onChanged: (value) {
                            user.email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter something';
                            } else if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid email';
                            }
                          },
                          
                             
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),

                      SizedBox(height: 30.0),
                      
                      Container(
                        
                        child: TextFormField(
                          obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                          controller: TextEditingController(text: user.email),
                          onChanged: (value) {
                            user.email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter something';
                            }
                            return null;
                          },
                         
                        ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),

                      ),
                       SizedBox(height: 15.0),
                   
                      Container(
                       decoration: ThemeHelper().buttonBoxDecoration(context),
                        
                          child: ElevatedButton(
                             style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  save();
                                } else {
                                  print("not ok");
                                }
                              },
                          ),
                          ), 
                        
                     Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color:   Color(0xffFF0000)),
                                    ),
                                  ]
                                )
                              ),
                            ),
                    ],
                  ),
                ),
                ]
              ),
            ),
          )
              ],
            ),
        ));
  }
}