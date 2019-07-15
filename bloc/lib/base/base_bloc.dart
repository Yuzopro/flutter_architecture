import 'package:flutter_architecture/flutter_architecture.dart';
import '../bean/loading_bean.dart';

abstract class BaseBloc<T extends LoadingBean> {
  static final String TAG = "BaseBloc";

  BehaviorSubject<T> _subject = BehaviorSubject<T>();

  Sink<T> get sink => _subject.sink;

  Stream<T> get stream => _subject.stream;

  void dispose() {
    _subject.close();
    sink.close();
  }
}
