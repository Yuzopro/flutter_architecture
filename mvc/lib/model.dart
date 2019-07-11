import 'package:flutter_architecture/flutter_architecture.dart';

class Model {
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  UserBean get userBean => _userBean;
  UserBean _userBean;

  Future login(String name, String password) async {
    final login = await LoginManager.instance.login(name, password);
    //授权成功
    if (login != null) {
      final user = await LoginManager.instance.getMyUserInfo();
      _userBean = user;
    }
    return;
  }

  void showLoading() {
    _isLoading = true;
  }

  void hideLoading() {
    _isLoading = false;
  }
}
