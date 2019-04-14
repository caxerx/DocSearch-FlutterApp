import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget{
  final String title;

  ListHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(15),
      color: Colors.black12,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.black87),
          )
        ],
      ),
    );
  }


}