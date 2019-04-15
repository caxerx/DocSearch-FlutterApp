import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  var focusNode1 = FocusNode();
  var focusNode2 = FocusNode();
  var focusNode3 = FocusNode();
  var focusNode4 = FocusNode();
  var focusNode5 = FocusNode();
  var focusNode6 = FocusNode();
  var birthdayController = new TextEditingController();

  var _gender = "";

  @override
  void initState() {
    focusNode5.addListener(() {
      if (focusNode5.hasFocus) {
        _selectDate();
        focusNode5.unfocus();
      }
    });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null)
      setState(() =>
          birthdayController.text = DateFormat("yyyy-MM-dd").format(picked));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20)),
          Image.asset("assets/docsearch_logo.png", height: 64),
          Text(
            "DocSearch",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode1),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  focusNode: focusNode1,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode2),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode3),
                  focusNode: focusNode2,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode4),
                  focusNode: focusNode3,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode5),
                  textInputAction: TextInputAction.next,
                  focusNode: focusNode4,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(
                          Icons.face,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Gender ",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = "M";
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (_) {
                                setState(() {
                                  _gender = "M";
                                });
                              },
                              groupValue: _gender,
                              value: "M",
                            ),
                            Text(
                              "Male ",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = "F";
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (_) {
                                setState(() {
                                  _gender = "F";
                                });
                              },
                              groupValue: _gender,
                              value: "F",
                            ),
                            Text(
                              "Female ",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode6),
                  controller: birthdayController,
                  textInputAction: TextInputAction.next,
                  focusNode: focusNode5,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.cake),
                    labelText: "Birthday",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                TextFormField(
                  onFieldSubmitted: (_) => _register(),
                  textInputAction: TextInputAction.done,
                  focusNode: focusNode6,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      child: Text("Register"),
                      textColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _register() {}
}
