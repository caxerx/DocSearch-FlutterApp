import 'package:flutter/material.dart';

class OnlineAppointmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
            ),
            title: Text("Dr. Chan Tai Man"),
            subtitle: Text("Dentist"),
          ),
          Divider(
            height: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.black45,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33),
                    child: Text(
                      "Date and Time",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 72, right: 15),
                child: Text(
                  "Jan 30, 2019 (Wed) 3:00 PM",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 72, top: 5, bottom: 5),
                child: GestureDetector(
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Start Consultation",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              )
            ],
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text("Consultation Type"),
            subtitle: Text("Online Consultation"),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text("Patient Name"),
            subtitle: Text("Chan Siu Man"),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text("Appointment ID"),
            subtitle: Text("446858414"),
          ),
        ],
      ),
    );
  }
}
