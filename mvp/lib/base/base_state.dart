import 'package:flutter/material.dart';

import 'base_presenter.dart';
import 'i_base_view.dart';

abstract class BaseState<T extends StatefulWidget, P extends BasePresenter<V>,
    V extends IBaseView> extends State<T> implements IBaseView {
  P presenter;

  bool isLoading = false;

  P initPresenter();

  Widget buildBody(BuildContext context);

  void initData() {
  }

  @override
  void initState() {
    super.initState();
    presenter = initPresenter();
    if (presenter != null) {
      presenter.onAttachView(this);
    }
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    if (presenter != null) {
      presenter.onDetachView();
      presenter = null;
    }
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildBody(context),
    );
  }

  @override
  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
