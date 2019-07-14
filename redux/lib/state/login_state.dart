class LoginState {
  final bool isLoading;
  final String token;

  LoginState({this.isLoading, this.token});

  factory LoginState.initial() {
    return LoginState(
      isLoading: false,
      token: '',
    );
  }

  LoginState copyWith({bool isLoading, String token}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
    );
  }
}
