import 'i_base_view.dart';

abstract class IBasePresenter<V extends IBaseView> {
  void onAttachView(V view);

  void onDetachView();
}