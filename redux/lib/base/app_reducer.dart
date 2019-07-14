import '../reducer/login_reducer.dart';
import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    loginState: loginReducer(state.loginState, action),
  );
}
