import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/bean/user_bean.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatelessWidget {
  final UserBean userBean;

  const HomePage({Key key, this.userBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: _getImageWidget(userBean.avatarUrl ?? "", 128.0),
            ),
            Text(
              userBean.login ?? "--",
              style: style,
            ),
            Text(
              userBean.email ?? "--",
              style: style,
            ),
            Text(
              userBean.blog ?? "--",
              style: style,
            ),
            Text(
              userBean.location ?? "--",
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImageWidget(String url, double size) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      placeholder: (context, url) {
        return SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: size,
        );
      },
      errorWidget: (context, url, error) {
        return SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: size,
        );
      },
      width: size,
      height: size,
    );
  }
}
