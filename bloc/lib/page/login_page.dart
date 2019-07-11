import 'package:flutter/material.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import '../base/bloc_provider.dart';
import '../bean/loading_bean.dart';
import '../bean/login_bloc_bean.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  LoadingBean<LoginBlocBean> initialData() {
    return LoadingBean(
      isLoading: false,
      data: LoginBlocBean(
        name: '',
        password: '',
        obscure: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

    _nameController.addListener(() {
      bloc.changeName(_nameController.text);
    });
    _passwordController.addListener(() {
      bloc.changePassword(_passwordController.text);
    });

    return StreamBuilder(
        stream: bloc.stream,
        initialData: initialData(),
        builder: (BuildContext context,
            AsyncSnapshot<LoadingBean<LoginBlocBean>> snapshot) {
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
                      _buildNameTextField(snapshot.data.data.name),
                      SizedBox(height: 30.0),
                      _buildPasswordTextField(
                          context, snapshot.data.data, bloc),
                      SizedBox(height: 60.0),
                      _buildLoginButton(context, snapshot.data.data, bloc),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !_isLoading(bloc),
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
        });
  }

  _isLoading(LoginBloc bloc) {
    return bloc.bean != null ? bloc.bean.isLoading : false;
  }

  _isValidLogin(LoginBlocBean bean) {
    String name = bean.name;
    String password = bean.password;

    return name.length > 0 && password.length > 0;
  }

  _login(BuildContext context, LoginBloc bloc) async {
    bloc.login(context);
  }

  Align _buildLoginButton(
      BuildContext context, LoginBlocBean bean, LoginBloc bloc) {
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
          onPressed: _isValidLogin(bean)
              ? () {
                  _login(context, bloc);
                }
              : null,
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  TextFormField _buildPasswordTextField(
      BuildContext context, LoginBlocBean bean, LoginBloc bloc) {
    return new TextFormField(
      controller: _passwordController,
      decoration: new InputDecoration(
        labelText: 'Github密码:',
        suffixIcon: new GestureDetector(
          onTap: () {
            bloc.changeObscure();
          },
          child:
              new Icon(bean.obscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      maxLines: 1,
      obscureText: bean.obscure,
    );
  }

  TextFormField _buildNameTextField(String name) {
    return new TextFormField(
      controller: _nameController,
      decoration: new InputDecoration(
        labelText: 'Github账号:',
        suffixIcon: new GestureDetector(
          onTap: () {
            _nameController.clear();
          },
          child: new Icon(name.length > 0 ? Icons.clear : null),
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
