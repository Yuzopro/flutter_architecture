import 'package:flutter/material.dart';
import 'package:flutter_architecture/flutter_architecture.dart';

import 'base/app_reducer.dart';
import 'base/app_state.dart';
import 'middleware/login_middleware.dart';
import 'page/login_page.dart';

void main() {
  final store = new Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoginMiddleware(),
    ],
  );

  runApp(
    ReduxApp(
      store: store,
    ),
  );
}

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  const ReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.black,
            ),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
