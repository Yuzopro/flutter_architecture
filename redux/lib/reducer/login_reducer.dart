import 'package:flutter_architecture/flutter_architecture.dart';
import 'package:redux/redux.dart';

import '../action/login_action.dart';
import '../state/login_state.dart';

const String TAG = "loginReducer";

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, RequestingLoginAction>(_requestingLogin),
  TypedReducer<LoginState, ReceivedLoginAction>(_receivedLogin),
  TypedReducer<LoginState, ErrorLoadingLoginAction>(_errorLoadingLogin),
]);

LoginState _requestingLogin(LoginState state, action) {
  LogUtil.v('_requestingLogin', tag: TAG);
  return state.copyWith(isLoading: true);
}

LoginState _receivedLogin(LoginState state, action) {
  LogUtil.v('_receivedLogin', tag: TAG);
  return state.copyWith(isLoading: false, token: action.token);
}

LoginState _errorLoadingLogin(LoginState state, action) {
  LogUtil.v('_errorLoadingLogin', tag: TAG);
  return state.copyWith(isLoading: false);
}
