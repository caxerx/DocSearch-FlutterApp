import 'package:docsearch/widget/MedicalRecordDetailsPage.dart';
import 'package:docsearch/widget/components/ListHeader.dart';
import 'package:docsearch/widget/components/MedicalRecordTile.dart';
import 'package:flutter/material.dart';

class MedicalRecordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Record"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListHeader("2019"),
            MedicalRecordTile("Dr. Michael Wang","Medical Record Simple Description",DateTime.now()),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
