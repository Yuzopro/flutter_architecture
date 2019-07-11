import 'package:flutter/material.dart';

import 'page/login_page.dart';

void main() => runApp(MVPApp());

class MVPApp extends StatelessWidget {
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
