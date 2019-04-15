import 'package:docsearch/widget/HomePage.dart';
import 'package:flutter/material.dart';

class DocSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DocSearch',
        theme: ThemeData(
            primaryColor: Colors.blue,
            primarySwatch: Colors.blue,
            fontFamily: 'Google Sans'),
        home: HomePage());
  }
}
