import 'package:docsearch/widget/ClinicAppointmentDetails.dart';
import 'package:docsearch/widget/OnlineAppointmentDetails.dart';
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ClinicAppointmentDetails()));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Dr. Chan Tai Man"),
                        Text("Tak Po Clinic")
                      ],
                    ),
                    subtitle: Text("28 Jan 2019, 11:00 PM"),
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OnlineAppointmentDetails()));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Dr. John Doe"),
                        Text("Online Consultation")
                      ],
                    ),
                    subtitle: Text("30 Jan 2019, 3:00 PM"),
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
