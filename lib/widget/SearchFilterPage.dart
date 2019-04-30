import 'package:doc_search/model/GlobalModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchFilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchFilterPageState();
  }
}

class SearchFilterPageState extends State<SearchFilterPage> {
  GlobalModel model;
  var _specialty = "";
  var _gender = "";
  var _location = "";
  var _language = "";

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
    _specialty = model.specialty;
    _gender = model.gender;
    _location = model.location;
    _language = model.language;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filter"),
          actions: <Widget>[
            FlatButton(
              child: Text("Save", style: TextStyle(color: Colors.white)),
              onPressed: () {
                model.specialty = _specialty;
                model.gender = _gender;
                model.location = _location;
                model.language = _language;
                Navigator.pop(context);
              },
            )
          ],
        ),
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
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  Text(
                    "Location",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            RadioListTile(
              value: "Island",
              groupValue: _location,
              title: Text("Hong Kong"),
              onChanged: (selected) {
                if (_location == selected) {
                  setState(() => _location = "Hong Kong");
                } else {
                  setState(() => _location = selected);
                }
              },
            ),
            RadioListTile(
              value: "Kowloon",
              groupValue: _location,
              title: Text("Kowloon"),
              onChanged: (selected) {
                if (_location == selected) {
                  setState(() => _location = "");
                } else {
                  setState(() => _location = selected);
                }
              },
            ),
            RadioListTile(
              value: "New Territories",
              groupValue: _location,
              title: Text("New Territories"),
              onChanged: (selected) {
                if (_location == selected) {
                  setState(() => _location = "");
                } else {
                  setState(() => _location = selected);
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  Text(
                    "Language",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            RadioListTile(
              value: "Cantonese",
              groupValue: _language,
              title: Text("Cantonese"),
              onChanged: (selected) {
                if (_language == selected) {
                  setState(() => _language = "");
                } else {
                  setState(() => _language = selected);
                }
              },
            ),
            RadioListTile(
              value: "Spanish",
              groupValue: _language,
              title: Text("Spanish"),
              onChanged: (selected) {
                if (_language == selected) {
                  setState(() => _language = "");
                } else {
                  setState(() => _language = selected);
                }
              },
            ),
            RadioListTile(
              value: "Mandarin",
              groupValue: _language,
              title: Text("Mandarin"),
              onChanged: (selected) {
                if (_language == selected) {
                  setState(() => _language = "");
                } else {
                  setState(() => _language = selected);
                }
              },
            ),
            RadioListTile(
              value: "English",
              groupValue: _language,
              title: Text("English"),
              onChanged: (selected) {
                if (_language == selected) {
                  setState(() => _language = "");
                } else {
                  setState(() => _language = selected);
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  Text(
                    "Gender",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            RadioListTile(
              value: "F",
              groupValue: _gender,
              title: Text("Female"),
              onChanged: (selected) {
                if (_gender == selected) {
                  setState(() => _gender = "");
                } else {
                  setState(() => _gender = selected);
                }
              },
            ),
            RadioListTile(
              value: "M",
              groupValue: _gender,
              title: Text("Male"),
              onChanged: (selected) {
                if (_gender == selected) {
                  setState(() => _gender = "");
                } else {
                  setState(() => _gender = selected);
                }
              },
            ),
          ],
        ));
  }
}
