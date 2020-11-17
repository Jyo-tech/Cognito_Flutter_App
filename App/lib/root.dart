import 'dart:io';

import 'package:Cognito_app/components/app_bar.dart';
import 'package:Cognito_app/globals.dart';
import 'package:Cognito_app/screens/loginPage.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

import 'globals.dart';
import 'screens/dashboard.dart';
import 'screens/loginPage.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isLoggedIn = false;
  List<Map<String, String>> gates = [];
  getGateway(var gateways, var locationId) {
    for (var gateway in gateways) {
      gates.add({
        "gatewayId": gateway["aGatewayId"].toString(),
        "locationId": locationId.toString()
      });
    }
  }

  getLocation(var locations) {
    if (locations["gateway"].isEmpty) {
      if (locations["locations"] == null) return;
      for (var location in locations["locations"]) {
        getLocation(location);
      }
    } else {
      getGateway(locations["gateway"], locations["locationid"]);
    }
  }

  afterLogin(
      //funct defination
      userName,
      isLoggedIn,
      companyId,
      groupName,
      companyApiKey,
      token,
      user) async {
    print("=======");
    userName = userName;
    this.isLoggedIn = isLoggedIn;
    companyId = companyId;
    groupName = groupName;
    companyApikey = companyApikey;
    token = token;
    user = user;
    print(this.isLoggedIn);
    try {
      Dio dio = new Dio();

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      Options options = new Options(contentType: "application/json", headers: {
        'Authorization': '$companyApikey $token $companyId $user',
      });

      final response = await dio.get(
          "https://wadiacsi1.cognitonetworks.com/cognito/entityweb/gatewayentities",
          options: options);
      for (int i = 0; i < response.data.length; i++) {
        getLocation(response.data[i]);
      }
      print(gates);

      setState(() {});
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  final titles = [
    "Dashboard",
    "IOT Networks",
    "Policy view",
    "Location View",
    "Graph View",
    "Video View"
  ];
  int _currentIndex = 0;
  final screens = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !this.isLoggedIn
          ? LoginScreen(callback: this.afterLogin)
          : Scaffold(
              body: screens[_currentIndex],
              backgroundColor: CognitoColors.background,
              appBar: DeepfakeAppBar(
                title: titles[_currentIndex],
              ),
              drawer: Drawer(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 124,
                      width: double.infinity,
                      color: CognitoColors.customBlue,
                      child: DrawerHeader(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black,
                                  border: Border.all(
                                      width: 3, color: Colors.black)),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 60.0,
                              ),
                            ),
                            Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                              // '$userName',
                              // style: TextStyle(fontStyle: FontStyle.italic),
                              // textScaleFactor: 2,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(children: <Widget>[
                        ListTile(
                          title: Text('Dashboard'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('IOT Networks'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Policy View'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Location View'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Graph View'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 4;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Video View'),
                          onTap: () {
                            setState(() {
                              _currentIndex = 5;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                    ),
                    Container(
                        decoration:
                            BoxDecoration(color: CognitoColors.customBlue),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              )),
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
