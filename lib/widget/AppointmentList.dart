import 'package:flutter/material.dart';

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment List"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Text("Upcoming", style: TextStyle(color: Colors.grey)),
                      Spacer()
                    ],
                  ),
                  color: Colors.black12),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Dr. Avatar"),
                        Text("ABC Clinic")
                      ],
                    ),
                    subtitle: Text("28 Jan 2019, 11:00 PM"),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
