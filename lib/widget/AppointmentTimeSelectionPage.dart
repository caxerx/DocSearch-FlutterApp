import 'package:docsearch/widget/AppointmentDetailsPage.dart';
import 'package:flutter/material.dart';

class AppointmentTimeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Request Appointment"),
          bottom: TabBar(
            labelColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Today - 20, Jan",
              ),
              Tab(
                text: "Tomorrow - 21 Jan",
              ),
              Tab(text: "Tue - 22 Jan"),
              Tab(text: "Wed - 23 Jan"),
              Tab(text: "Thu - 24 Jan"),
              Tab(text: "Fri - 25 Jan"),
              Tab(text: "Sat - 26 Jan"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("No available time"),),
            TimeSelector(),
            TimeSelector(),
            TimeSelector(),
            TimeSelector(),
            TimeSelector(),
            TimeSelector(),
          ],
        ),
      ),
    );
  }
}

class TimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Midnight",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 7.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('00:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('01:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('02:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('03:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('04:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Morning",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 7.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('08:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('08:30'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('09:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('03:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('09:30'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Afternoon",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 7.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('14:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('14:30'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('15:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('15:30'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('16:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Evening",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 7.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('19:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('20:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('21:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('22:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text('23:00'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage()));
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
