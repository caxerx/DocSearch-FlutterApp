import 'package:flutter/material.dart';

class MedicalInfoTile extends StatelessWidget{
  final String imageLink;
  final String title;
  final String content;
  final String date;
  final String source;
  MedicalInfoTile(this.imageLink,this.title,this.content,this.date,this.source);

  @override
  Widget build(BuildContext context) {
    return
          GestureDetector(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Image.network(
                        imageLink,
                        width: 128,
                        height: 96,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                             title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              content,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "$date - $source",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color:Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

}