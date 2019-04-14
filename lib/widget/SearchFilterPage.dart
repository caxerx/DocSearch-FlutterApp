import 'package:flutter/material.dart';

class SearchFilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchFilterPageState();
  }
}

class SearchFilterPageState extends State<SearchFilterPage> {
  var _specialty = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Filter")),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  Text(
                    "Specialty",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            RadioListTile(
              value: "General Pratice",
              groupValue: _specialty,
              title: Text("General Pratice"),
              onChanged: (selected) {
                if (_specialty == selected) {
                  setState(() => _specialty = "");
                } else {
                  setState(() => _specialty = selected);
                }
              },
            ),
            RadioListTile(
              value: "Cardiology",
              groupValue: _specialty,
              title: Text("Cardiology"),
              onChanged: (selected) {
                if (_specialty == selected) {
                  setState(() => _specialty = "");
                } else {
                  setState(() => _specialty = selected);
                }
              },
            ),
            RadioListTile(
              value: "Dentisry",
              groupValue: _specialty,
              title: Text("Dentisry"),
              onChanged: (selected) {
                if (_specialty == selected) {
                  setState(() => _specialty = "");
                } else {
                  setState(() => _specialty = selected);
                }
              },
            ),
            RadioListTile(
              value: "Dietetics",
              groupValue: _specialty,
              title: Text("Dietetics"),
              onChanged: (selected) {
                if (_specialty == selected) {
                  setState(() => _specialty = "");
                } else {
                  setState(() => _specialty = selected);
                }
              },
            ),
          ],
        ));
  }
}
