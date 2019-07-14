import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import 'model.dart';

class Con {
  factory Con() => _getInstance();

  static Con get instance => _getInstance();
  static Con _instance;

  Con._internal();

  static Con _getInstance() {
    if (_instance == null) {
      _instance = new Con._internal();
    }
    return _instance;
  }

  static final model = Model();

  static bool get isLoading => model.isLoading;

  static UserBean get userBean => model.userBean;

  Future login(State state, String name, String password) async {
    state.setState(() {
      _showLoading();
    });

    await model.login(name, password);

    state.setState(() {
      _hideLoading();
    });
  }

  void _showLoading() {
    model.showLoading();
  }

  void _hideLoading() {
    model.hideLoading();
  }
}