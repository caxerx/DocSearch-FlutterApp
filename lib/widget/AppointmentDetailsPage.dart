import 'package:docsearch/widget/AppointmentList.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Appointment"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  ListTile(
                    title: Text("Appointment Information"),
                  ),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://movies4maniacs.liberty.me/wp-content/uploads/sites/1218/2015/09/avatarsucks.jpg"),
                    ),
                    title: Text("Dr. Suneela Nayak"),
                    subtitle: Text("Pediatrician"),
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("Date"),
                    subtitle: Text("Jan 23, 2019"),
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text("Time"),
                    subtitle: Text("2:30 PM"),
                  )
                ])),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  ListTile(
                    title: Text("Patient Information"),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Patient Name",
                          icon: Icon(Icons.accessibility)),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Email", icon: Icon(Icons.mail)),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Phone Number", icon: Icon(Icons.phone)),
                    ),
                  ),
                ])),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: RaisedButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppointmentList()));
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
