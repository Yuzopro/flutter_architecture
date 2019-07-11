import 'package:flutter_architecture/bean/login_bean.dart';
import 'package:flutter_architecture/bean/user_bean.dart';
import 'package:flutter_architecture/config.dart';
import 'package:flutter_architecture/http/api.dart';
import 'package:flutter_architecture/http/credentials.dart';
import 'package:flutter_architecture/http/http_manager.dart';

class LoginManager {
  factory LoginManager() => _getInstance();

  static LoginManager get instance => _getInstance();
  static LoginManager _instance;

  String _token;

  LoginManager._internal();

  static LoginManager _getInstance() {
    if (_instance == null) {
      _instance = new LoginManager._internal();
    }
    return _instance;
  }

  login(String userName, String password) async {
    _token = Credentials.basic(userName, password);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": Config.CLIENT_ID,
      "client_secret": Config.CLIENT_SECRET
    };
    final response =
        await HttpManager.doPost(Api.authorizations(), requestParams);
    if (response != null && response.data != null) {
      return LoginBean.fromJson(response.data);
    }
    return null;
  }

  getMyUserInfo() async {
    final response = await HttpManager.doGet(Api.getMyUserInfo());
    if (response != null && response.data != null) {
      return UserBean.fromJson(response.data);
    }
    return null;
  }

  void setToken(String token, bool isNeedCache) {
    _token = token;
  }

  String getToken() {
    String auth = _token;
    if (_token != null && _token.length > 0) {
      auth = _token.startsWith("Basic") ? _token : "token " + _token;
    }
    return auth;
  }
}
