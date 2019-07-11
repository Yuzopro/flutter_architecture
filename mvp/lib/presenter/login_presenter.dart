import 'package:flutter_architecture/flutter_architecture.dart';

import '../contract/login_contract.dart';

class LoginPresenter extends ILoginPresenter {
  @override
  void login(String name, String password) async {
    if (view != null) {
      view.showLoading();
    }
    final login = await LoginManager.instance.login(name, password);
    //授权成功
    if (login != null) {
      final user = await LoginManager.instance.getMyUserInfo();
      if (user != null) {
        if (view != null) {
          view.hideLoading();
          view.onLoginSuccess(user);
        } else {
          view.hideLoading();
          view.onLoginFailed();
        }
      }
    } else {
      if (view != null) {
        view.hideLoading();
        view.onLoginFailed();
      }
    }
  }
}
