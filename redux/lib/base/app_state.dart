import 'package:flutter/material.dart';

import '../state/login_state.dart';

class AppState {
  final LoginState loginState;

  AppState({
    this.loginState,
  });

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
      );
}
