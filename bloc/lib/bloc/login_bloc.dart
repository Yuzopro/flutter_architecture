import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import '../base/base_bloc.dart';
import '../bean/loading_bean.dart';
import '../bean/login_bloc_bean.dart';

class LoginBloc extends BaseBloc<LoadingBean<LoginBlocBean>> {
  LoadingBean<LoginBlocBean> bean;

  LoginBloc() {
    bean = LoadingBean<LoginBlocBean>(
      isLoading: false,
      data: LoginBlocBean(
        name: '',
        password: '',
        obscure: true,
      ),
    );
  }

  changeObscure() {
    bean.data.obscure = !bean.data.obscure;
    sink.add(bean);
  }

  changeName(String name) {
    bean.data.name = name;
    sink.add(bean);
  }

  changePassword(String password) {
    bean.data.password = password;
    sink.add(bean);
  }

  login(BuildContext context) async {
    _showLoading();

    final login =
        await LoginManager.instance.login(bean.data.name, bean.data.password);
    //授权成功
    if (login != null) {
      final user = await LoginManager.instance.getMyUserInfo();
      if (user != null) {
        NavigatorUtil.goHome(context, user);
      } else {
        ToastUtil.showToast('登录失败，请重新登录');
      }
    } else {
      ToastUtil.showToast('登录失败，请重新登录');
    }

    _hideLoading();
  }

  void _showLoading() {
    bean.isLoading = true;
    sink.add(bean);
  }

  void _hideLoading() {
    bean.isLoading = false;
    sink.add(bean);
  }
}
