import 'package:Cognito_app/root.dart';
import 'package:flutter/material.dart';

void main() => runApp(DeepfakeApp());

class DeepfakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognito app',
      routes: {
        '/': (context) => Root(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
    );
  }
}
