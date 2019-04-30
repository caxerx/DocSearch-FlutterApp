import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/ClinicAppointmentDetails.dart';
import 'package:doc_search/widget/OnlineAppointmentDetails.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scoped_model/scoped_model.dart';

class AppointmentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppointmentListState();
  }
}

class AppointmentListState extends State<AppointmentList> {
  GlobalModel model;
  var df = DateFormat("yyyy-MM-d h:mm a");

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
  }

  var rq = """
query(\$id: ID!) {
  patient(id: \$id) {
    reservations {
      id
      startTime
      status
      type
      doctor{
        name
        avatar
      }
      workplace{
        name
      }
    }
  }
}
  """;

  List<List<dynamic>> r;

  var tn = [
    "Queued",
    "Upcoming",
    "Waiting For Approve",
    "Finished",
    "Rejected",
    "Cancelled"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appointment List"),
        ),
        body: Query(
          options: QueryOptions(
              document: rq, variables: {"id": model.loggedInUserId}),
          builder: (data) {
            if (data.loading) {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(),
              );
            }
            print(data.data);
            r = List();
            List<dynamic> resv = data.data['patient']['reservations'];
            r.add(resv.where((r) => r['status'] == 'waiting').toList());
            r.add(resv.where((r) => r['status'] == 'approved').toList());
            r.add(resv.where((r) => r['status'] == 'pending').toList());
            r.add(resv.where((r) => r['status'] == 'finished').toList());
            r.add(resv.where((r) => r['status'] == 'rejected').toList());
            r.add(resv.where((r) => r['status'] == 'cancelled').toList());

            return ListView.builder(
                itemCount: r.length,
                itemBuilder: (ctx, idx) {
                  var l = r[idx];
                  return Builder(
                    builder: (ctx) {
                      if (l.length == 0) {
                        return Container();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: <Widget>[
                                  Text(tn[idx],
                                      style: TextStyle(color: Colors.grey)),
                                  Spacer()
                                ],
                              ),
                              color: Colors.black12),
                          Column(
                            children: List.generate(l.length, (idx2) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  l[idx2]['type']=="online"?OnlineAppointmentDetails(l[idx]['id']):ClinicAppointmentDetails(l[idx]['id'])));
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: (l[idx2]["doctor"]
                                                      ['avatar'] ==
                                                  null ||
                                              l[idx2]["doctor"]['avatar'] == "")
                                          ? AssetImage("assets/noavatar.png")
                                          : NetworkImage(
                                              "https://dsapi.1lo.li/assets/avatars/" +
                                                  l[idx2]["doctor"]['avatar']),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            "Dr. ${l[idx2]["doctor"]['name']}"),
                                        l[idx2]['type'] == "online"
                                            ? Text("Online Consultation")
                                            : Text(l[idx2]["workplace"]['name'])
                                      ],
                                    ),
                                    subtitle: Text(df.format(
                                        DateTime.parse(l[idx2]["startTime"])
                                            .add(Duration(hours: 8)))),
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      );
                    },
                  );
                });
          },
        ));
  }
}
