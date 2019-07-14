import 'package:flutter/material.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import '../base/base_state.dart';
import '../contract/login_contract.dart';
import '../presenter/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseState<LoginPage, LoginPresenter, ILoginView>
    implements ILoginView {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _obscureText = true;

  @override
  void initData() {
    super.initData();
    _nameController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Form(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                _buildTitle(),
                _buildTitleLine(),
                SizedBox(height: 70.0),
                _buildNameTextField(),
                SizedBox(height: 30.0),
                _buildPasswordTextField(context),
                SizedBox(height: 60.0),
                _buildLoginButton(context),
              ],
            ),
          ),
          Offstage(
            offstage: !isLoading,
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black54,
              child: new Center(
                child: SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  LoginPresenter initPresenter() {
    return LoginPresenter();
  }

  _isValidLogin() {
    String name = _nameController.text;
    String password = _passwordController.text;

    return name.length > 0 && password.length > 0;
  }

  _login() {
    if (presenter != null) {
      String name = _nameController.text;
      String password = _passwordController.text;
      presenter.login(name, password);
    }
  }

  @override
  void onLoginSuccess(UserBean userBean) {
    NavigatorUtil.goHome(context, userBean);
  }

  @override
  void onLoginFailed() {
    ToastUtil.showToast('登录失败，请重新登录');
  }

  Align _buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: _isValidLogin()
              ? () {
                  _login();
                }
              : null,
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  TextFormField _buildPasswordTextField(BuildContext context) {
    return new TextFormField(
      controller: _passwordController,
      decoration: new InputDecoration(
        labelText: 'Github密码:',
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      maxLines: 1,
      obscureText: _obscureText,
    );
  }

  TextFormField _buildNameTextField() {
    return new TextFormField(
      controller: _nameController,
      decoration: new InputDecoration(
        labelText: 'Github账号:',
        suffixIcon: new GestureDetector(
          onTap: () {
            _nameController.clear();
          },
          child: new Icon(_nameController.text.length > 0 ? Icons.clear : null),
        ),
      ),
      maxLines: 1,
    );
  }

  Padding _buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '登录',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
