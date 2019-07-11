import 'package:flutter/material.dart';

import 'page/login_page.dart';

void main() => runApp(MVCApp());

class MVCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: LoginPage(),
    );
  }
}
