import 'package:docsearch/widget/HomePage.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appointment Result"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 90,
                ),
              ),
              Text(
                "Appointment Requested",
                style: TextStyle(fontSize: 26),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Your Appointment is requested, you will recieve a message or phone call from clinic if your appointment is confirmed.",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Back to Home"),
                onPressed: () {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ));
  }
}
