import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import '../action/login_action.dart';
import '../base/app_state.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {
  static final String TAG = "LoginMiddleware";

  @override
  void call(Store store, action, NextDispatcher next) {
    next(action);
    if (action is FetchLoginAction) {
      _doLogin(next, action.context, action.userName, action.password);
    }
  }

  Future<void> _doLogin(NextDispatcher next, BuildContext context,
      String userName, String password) async {
    next(RequestingLoginAction());

    try {
      LoginBean loginBean =
          await LoginManager.instance.login(userName, password);
      if (loginBean != null) {
        String token = loginBean.token;
        LoginManager.instance.setToken(loginBean.token, true);
        UserBean userBean = await LoginManager.instance.getMyUserInfo();
        if (userBean != null) {
          next(ReceivedLoginAction(token, userBean));
          NavigatorUtil.goHome(context, userBean);
        } else {
          ToastUtil.showToast('登录失败请重新登录');
          LoginManager.instance.setToken(null, true);
        }
      } else {
        ToastUtil.showToast('登录失败请重新登录');
        next(ErrorLoadingLoginAction());
      }
    } catch (e) {
      LogUtil.v(e, tag: TAG);
      ToastUtil.showToast('登录失败请重新登录');
      next(ErrorLoadingLoginAction());
    }
  }
}
