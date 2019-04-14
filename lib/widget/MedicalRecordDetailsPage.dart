import 'package:docsearch/widget/components/ListHeader.dart';
import 'package:flutter/material.dart';

class MedicalRecordDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Record"),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        minRadius: 40,
                        maxRadius: 40,
                        backgroundImage: NetworkImage(
                            "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Record By:",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Dr. Michael Wang",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "At 14 Apirl 2019 5:28 PM",
                              overflow: TextOverflow.ellipsis,
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
          ),
          Divider(
            height: 1,
          ),
          ListHeader("Symptoms"),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text("Symptom Name"),
            subtitle: Text("Symptom Description"),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
