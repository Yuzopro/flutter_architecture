import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/bean/user_bean.dart';
import 'package:flutter_architecture/page/home_page.dart';

class NavigatorUtil {
  //主页
  static goHome(BuildContext context, UserBean userBean) {
    Navigator.pushReplacement(
      context,
      new CupertinoPageRoute(
        builder: (context) => HomePage(
              userBean: userBean,
            ),
      ),
    );
  }
}
