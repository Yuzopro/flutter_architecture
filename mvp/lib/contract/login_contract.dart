import 'package:flutter_architecture/flutter_architecture.dart';

import '../base/base_presenter.dart';
import '../base/i_base_view.dart';

abstract class ILoginPresenter<V extends ILoginView> extends BasePresenter<V> {
  void login(String name, String password);
}

abstract class ILoginView extends IBaseView {
  void onLoginSuccess(UserBean userBean);

  void onLoginFailed();
}
