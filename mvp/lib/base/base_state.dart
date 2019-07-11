import 'package:flutter/material.dart';

import 'base_presenter.dart';
import 'i_base_view.dart';

abstract class BaseState<T extends StatefulWidget, P extends BasePresenter<V>,
    V extends IBaseView> extends State<T> implements IBaseView {
  String title = "";

  P presenter;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;

  P initPresenter();

  Widget buildBody(BuildContext context);

  void initData() {
    this.title = getTitle();
  }

  String getTitle() {
    return "";
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
      key: _scaffoldKey,
      appBar: title.isEmpty
          ? null
          : new AppBar(
              actions: getActions(),
              title: new Text(title),
            ),
      body: buildBody(context),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    return null;
  }

  List<Widget> getActions() {
    return null;
  }

  @override
  showToast(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
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
