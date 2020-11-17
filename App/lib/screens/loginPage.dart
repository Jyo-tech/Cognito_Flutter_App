import 'dart:io';

import 'package:Cognito_app/colors.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:Cognito_app/globals.dart';

import 'dashboard.dart';

void main() => runApp(new LoginScreen());

class LoginScreen extends StatefulWidget {
  final Function callback; //hello????r u there???????

  const LoginScreen({Key key, this.callback}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isApiCalled = false;
  bool isLoggedIn = false;

  TextEditingController usernameController, passwordController;
  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  handleLogin(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;
    try {
      this.setState(() {
        this.isApiCalled = true;
      });

      try {
        Dio dio = new Dio();
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };

        final res = await dio.post(
          'https://wadiacsi1.cognitonetworks.com/cognito/gettoken',
          data: new FormData.fromMap({
            "username": "richam@test.com",
            "password": "eqAJ0aGe3bIVQEl0",
            //  "username": username,
            // "password": password,
          }),
        );
        userName = res.data["userName"];
        companyId = res.data["companyId"];
        groupName = res.data["group_name"];
        companyApikey = res.data["companyApikey"];
        token = res.data["token"];
        isLoggedIn = res.data["success"];
        user = res.data["user"];
        print(res.statusCode);
        print(res.statusMessage);
        print(res.data);
        this.widget.callback(
            userName, true, companyId, groupName, companyApikey, token, user);
      } catch (e) {
        print(e);
      }
    } on DioError catch (e) {
      this.setState(() {
        this.isApiCalled = false;
      });
      if (e.response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white70,
              content: Text(
                'Oops! Something went wrong. Perhaps check your username and password',
                style: TextStyle(
                  color: Colors.black12,
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      color: Colors.black12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Scaffold(
        backgroundColor: Colors.lightBlue,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // new Image(
            //   image: new AssetImage("assets/bg.png"),
            //   fit: BoxFit.cover,
            //   color: Colors.white10,
            //   colorBlendMode: BlendMode.softLight,
            // ),
            // Image.asset(
            //   'assets/coglogo.jpg',
            //   scale: 9,
            //   alignment: new Alignment(-0.92, -0.90),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 70),
              child: Text("Powering IOT for\nSmarter Enterprice",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700])),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text("SIGN IN WITH CREDENTIALS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[700])),
                  ),
                  new Form(
                    child: new Theme(
                      data: new ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch: Colors.teal,
                          inputDecorationTheme: new InputDecorationTheme()),
                      child: new Container(
                        padding: const EdgeInsets.only(left: 40.0, right: 40),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: usernameController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username',
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.grey[700]),
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[700],
                                  ),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 3.0, top: 3.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[700]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[700]),
                                  )),
                            ),
                            new Padding(
                              padding: const EdgeInsets.all(10.0),
                            ),
                            new TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: passwordController,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Password",
                                  prefixIcon: Icon(Icons.lock_open,
                                      color: Colors.grey[700]),
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[700],
                                  ),
                                  filled: true,
                                  fillColor: Colors.white60,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 3.0, top: 3.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                    borderSide:
                                        BorderSide(color: Colors.brown[500]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                    borderSide:
                                        BorderSide(color: Colors.brown[500]),
                                  )),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ButtonTheme(
                                minWidth: 110,
                                height: 40,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green[400],
                                  child: Text("SIGN IN"),
                                  onPressed: () => {
                                    this.handleLogin(context),
                                    //function for API call
                                  },
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OutlinedTextFormField extends StatefulWidget {
  const OutlinedTextFormField({
    Key key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.validationMessage,
    this.isPassword,
    this.controller,
  }) : super(key: key);

  final prefixIcon,
      suffixIcon,
      hintText,
      validationMessage,
      isPassword,
      controller;

  @override
  _OutlinedTextFormFieldState createState() => _OutlinedTextFormFieldState();
}

class _OutlinedTextFormFieldState extends State<OutlinedTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: TextFormField(
        controller: this.widget.controller,
        obscureText: obscureText && this.widget.isPassword,
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: this.widget.prefixIcon != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    this.widget.prefixIcon,
                    size: 18,
                  ),
                  color: CognitoColors.secondary,
                )
              : null,
          hintStyle: TextStyle(
            color: CognitoColors.secondary.withOpacity(0.7),
          ),
          hintText: this.widget.hintText,
          focusColor: CognitoColors.secondary,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CognitoColors.secondary, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CognitoColors.secondary, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CognitoColors.secondary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CognitoColors.danger, width: 2.0),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return this.widget.validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
