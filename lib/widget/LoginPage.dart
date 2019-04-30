import 'dart:async';

import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  var registerDoc = """
      mutation(\$pid: ID!, \$t: String!) {
        registerPushNotification(patientId: \$pid, token: \$t) {
          token
        }
      }

    """;

  var focusNode = FocusNode();
  var loggingIn = false;
  GlobalModel model;

  TextEditingController unameCtrl = new TextEditingController();
  TextEditingController pwCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);

    unameCtrl.addListener(() => model.inputUsername = unameCtrl.text);
    pwCtrl.addListener(() => model.inputPassword = pwCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ModalProgressHUD(
      child: Builder(builder: (ctx) {
        if (loggingIn) {
          return GraphQLConsumer(builder: (gql) {
            return _loginWidget(gql);
          });
        } else {
          return ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50)),
              Image.asset("assets/docsearch_logo.png", height: 150),
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
                      controller: unameCtrl,
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
                      controller: pwCtrl,
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
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
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
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      },
                      child: Text(
                        "Sign up for an account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
      }),
      inAsyncCall: loggingIn,
    )));
  }

  void _login() {
    setState(() {
      loggingIn = true;
    });
  }

  loginSuccess(gql) async {
    gql.mutate(MutationOptions(
        document: registerDoc,
        variables: {"pid": model.loggedInUserId, "t": model.token}));
    Timer(Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });
  }

  showDiag() async {
    Timer(Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("Incorrect Username and Password"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    });
  }

  setNotLoading() async {
    Timer(Duration(milliseconds: 10), () {
      setState(() {
        loggingIn = false;
      });
    });
  }

  Widget _loginWidget(gql) {
    String loginDocument = """
    query(\$username:String!, \$password:String!){
      patientLogin(username:\$username, password:\$password){
        success
        patient{
          name
          id
        }
      }
    }
    """;
    return Query(
      options: QueryOptions(document: loginDocument, variables: {
        "username": model.inputUsername,
        "password": model.inputPassword
      }),
      builder: (res) {
        if (!res.loading) {
          bool success = res.data['patientLogin']['success'];
          if (success) {
            model.loggedInUserId = res.data['patientLogin']['patient']['id'];
            loginSuccess(gql);
          } else {
            showDiag();
          }
          setNotLoading();
        } else {}
        return Container();
      },
    );
  }
}
