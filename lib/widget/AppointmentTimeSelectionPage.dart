import 'package:doc_search/widget/AppointmentDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AppointmentTimeSelectionPage extends StatefulWidget {
  String pid;
  String type;

  AppointmentTimeSelectionPage(this.pid, this.type);

  @override
  State createState() {
    return AppointmentTimeSelectionPageState(pid, type);
  }
}

class AppointmentTimeSelectionPageState
    extends State<AppointmentTimeSelectionPage> {
  var today = DateTime.now();
  var df = DateFormat("dd MMM");
  var dfe = DateFormat("E");

  String pid;
  String type;

  AppointmentTimeSelectionPageState(this.pid, this.type);

  @override
  void initState() {
    super.initState();
  }

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
                text: "Today - ${df.format(today)}",
              ),
              Tab(
                text: "Tomorrow - ${df.format(today.add(Duration(days: 1)))}",
              ),
              Tab(
                  text:
                      "${dfe.format(today.add(Duration(days: 2)))} - ${df.format(today.add(Duration(days: 2)))}"),
              Tab(
                  text:
                      "${dfe.format(today.add(Duration(days: 3)))} - ${df.format(today.add(Duration(days: 3)))}"),
              Tab(
                  text:
                      "${dfe.format(today.add(Duration(days: 4)))} - ${df.format(today.add(Duration(days: 4)))}"),
              Tab(
                  text:
                      "${dfe.format(today.add(Duration(days: 5)))} - ${df.format(today.add(Duration(days: 5)))}"),
              Tab(
                  text:
                      "${dfe.format(today.add(Duration(days: 6)))} - ${df.format(today.add(Duration(days: 6)))}"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TimeSelector(today, pid, type),
            TimeSelector(today.add(Duration(days: 1)), pid, type),
            TimeSelector(today.add(Duration(days: 2)), pid, type),
            TimeSelector(today.add(Duration(days: 3)), pid, type),
            TimeSelector(today.add(Duration(days: 4)), pid, type),
            TimeSelector(today.add(Duration(days: 5)), pid, type),
            TimeSelector(today.add(Duration(days: 6)), pid, type),
          ],
        ),
      ),
    );
  }
}

class TimeSlot {
  DateTime start;
  DateTime end;

  TimeSlot(DateTime d, String s, String e) {
    var sp = s.split(":");
    start = new DateTime(
        d.year, d.month, d.day, int.parse(sp[0]), int.parse(sp[1]));
    var ep = e.split(":");
    end = new DateTime(
        d.year, d.month, d.day, int.parse(ep[0]), int.parse(ep[1]));
  }
}

class TimeSelector extends StatelessWidget {
  String dGdts = """
  query(\$date: DateTime!, \$doctorId: ID!) {
    getDoctorTimeSlots(date: \$date, doctorId: \$doctorId) {
      id
      weekday
      start
      end
    }
  }
  """;

  DateTime d;
  String did;
  String type;

  var dfhm = DateFormat("HH:mm");

  TimeSelector(this.d, this.did, this.type);

  List<String> dd = ["Midnight", "Morning", "Afternoon", "Evening"];
  Map<String, List<TimeSlot>> tsl;

  int coutall(Map a) {
    int c = 0;
    for (var d in a.keys) {
      if (a[d] != null) {
        c += a[d].length;
      }
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: dGdts,
          variables: {"doctorId": did, "date": d.toIso8601String()}),
      builder: (data) {
        if (data.loading) {
          return ModalProgressHUD(
            child: Container(),
            inAsyncCall: true,
          );
        }
        tsl = Map();
        var ls = data.data['getDoctorTimeSlots'];
        for (var t in ls) {
          var tsn = TimeSlot(d, t['start'], t['end']);
          if (tsn.start.hour >= 0 && tsn.start.hour <= 6) {
            if (tsl['Midnight'] == null) {
              tsl['Midnight'] = new List();
            }
            tsl['Midnight'].add(tsn);
          }
          if (tsn.start.hour >= 7 && tsn.start.hour <= 11) {
            if (tsl['Morning'] == null) {
              tsl['Morning'] = new List();
            }
            tsl['Morning'].add(tsn);
            //morning
          }
          if (tsn.start.hour >= 12 && tsn.start.hour <= 18) {
            if (tsl['Afternoon'] == null) {
              tsl['Afternoon'] = new List();
            }
            tsl['Afternoon'].add(tsn);
            //afternoon
          }
          if (tsn.start.hour >= 19 && tsn.start.hour <= 23) {
            if (tsl['Evening'] == null) {
              tsl['Evening'] = new List();
            }
            tsl['Evening'].add(tsn);
            //evening
          }
        }
        return coutall(tsl) == 0
            ? Center(
                child: Text("No available time"),
              )
            : Container(
                child: ListView(
                children: List.generate(dd.length, (idx) {
                  if (tsl[dd[idx]] == null) {
                    return Container();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.black12,
                        child: Row(
                          children: <Widget>[
                            Text(
                              dd[idx],
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
                            children: List.generate(
                                tsl[dd[idx]] == null ? 0 : tsl[dd[idx]].length,
                                (idx2) {
                              return OutlineButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child:
                                    Text(dfhm.format(tsl[dd[idx]][idx2].start)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentDetailsPage(did,
                                                  tsl[dd[idx]][idx2], type)));
                                },
                              );
                            })),
                      ),
                    ],
                  );
                }),

                /*



           */
              ));
      },
    );
  }
}
