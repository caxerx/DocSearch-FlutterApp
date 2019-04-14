import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
          Image.asset("assets/docsearch_logo.png",height: 200),
          Text(
            "DocSearch",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Log in to continue",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(focusNode),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
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
                  onFieldSubmitted: (_) => _login(),
                  focusNode: focusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 50,
                    right: 50
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      child: Text("Login"),
                      textColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: () {
                        _login();
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                ),
                GestureDetector(
                  child: Text(
                    "Sign up for an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
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

  void _login() {}
}
