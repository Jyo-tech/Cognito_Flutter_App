import 'package:Cognito_app/globals.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        userName,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
