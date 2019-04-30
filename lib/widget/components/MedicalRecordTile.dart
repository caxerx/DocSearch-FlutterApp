import 'package:doc_search/widget/MedicalRecordDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalRecordTile extends StatelessWidget{
  final String drName;
  final String description;
  final DateTime date;

  MedicalRecordTile(this.drName, this.description, this.date);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MedicalRecordDetailsPage()));
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                  elevation: 4,
                  color: Colors.white70,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          DateFormat("dd").format(date),
                          style: TextStyle(
                              fontSize: 38, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            DateFormat("MMM").format(date),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 5, bottom: 5, right: 5, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dr. Lee Siu Ming",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Simple Description for the record.",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey),
                      )
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