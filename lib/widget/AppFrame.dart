import 'package:flutter/material.dart';

class AppFrame extends StatelessWidget {
  var child;
  var appbarTitle;

  AppFrame({Widget appbarTitle, Widget child}) {
    this.child = child;
    this.appbarTitle = appbarTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appbarTitle,
        ),
        body: child);
  }
}
