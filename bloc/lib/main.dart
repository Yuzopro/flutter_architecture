import 'package:flutter/material.dart';

import 'base/bloc_provider.dart';
import 'bloc/login_bloc.dart';
import 'page/login_page.dart';

void main() => runApp(BlocApp());

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: BlocProvider<LoginBloc>(
        child: LoginPage(),
        bloc: LoginBloc(),
      ),
    );
  }
}
