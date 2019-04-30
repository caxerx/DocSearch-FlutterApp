import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/ProfilePage.dart';
import 'package:doc_search/widget/VideoConsultationPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:scoped_model/scoped_model.dart';

class OnlineAppointmentDetails extends StatefulWidget {
  final String id;

  OnlineAppointmentDetails(this.id);

  @override
  State<StatefulWidget> createState() {
    return OnlineAppointmentDetailsState(id);
  }
}

class OnlineAppointmentDetailsState extends State<OnlineAppointmentDetails> {
  GlobalModel model;

  //Jan 30, 2019 (Wed) 3:00 PM
  var dt = DateFormat("MMM dd, yyyy (EEE) h:mm a");
  var qod = """
query(\$id: ID!) {
  reservation(id: \$id) {
    id
    note
    doctor{
      id
      name
      avatar
      specialty
    }
    startTime
    status
    workplace{
      id
    }
    consultation{
      id
    }
    
  }
}
""";

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
  }

  var _loading = false;

  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (gql) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Appointment Details"),
          ),
          body: ModalProgressHUD(
              inAsyncCall: _loading,
              child: Query(
                  options: QueryOptions(
                      document: qod,
                      variables: {"id": id},
                      fetchPolicy: FetchPolicy.noCache),
                  builder: (data) {
                    if (data.loading)
                      return ModalProgressHUD(
                        inAsyncCall: true,
                        child: Container(),
                      );
                    var res = data.data['reservation'];
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePage(res["doctor"]['id'])));
                          },
                          leading: CircleAvatar(
                            backgroundImage: (res["doctor"]["avatar"] == null ||
                                res["doctor"]["avatar"] == "")
                                ? AssetImage("assets/noavatar.png")
                                : NetworkImage(
                                "https://dsapi.1lo.li/assets/avatars/" +
                                    res["doctor"]["avatar"]),
                          ),
                          title: Text("Dr. ${res["doctor"]["name"]}"),
                          subtitle: Text(
                              ReCase(res["doctor"]["specialty"]).titleCase),
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
                                dt.format(DateTime.parse(res["startTime"])
                                    .add(Duration(hours: 8))),
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                            Builder(
                              builder: (b) {
                                if (res["status"] == "approved") {
                                  return getFlatBtn("Ready", null, gql, res);
                                }
                                if (res["status"] == "waiting") {
                                  return getFlatBtn("Start Consultation",
                                      VideoConsultationPage(), gql, res);
                                }
                                return Container(
                                  padding: EdgeInsets.only(bottom: 10),);
                              },
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
                          leading: Icon(Icons.check),
                          title: Text("Appointment ID"),
                          subtitle: Text(res["id"]),
                        ),
                      ],
                    );
                  })));
    });
  }

  String id;

  OnlineAppointmentDetailsState(this.id);

  var ccd = """
mutation(\$workplaceId: ID!, \$doctorId: ID!, \$patientId: ID!, \$reservationId: ID! ,\$startTime: DateTime!) {
  createConsultation(
    data: {
      workplaceId: \$workplaceId
      consultantId: \$doctorId
      patientId: \$patientId
      note: ""
      startTime: \$startTime
      endTime: \$startTime
      type: "online"
      diseaseIds: []
      reservationId: \$reservationId
      prescription: ""
    }
  ) {
    id
  }
}
  """;

  var erd = """
  mutation(
  \$consultationId: ID!
  \$workplaceId: ID!
  \$doctorId: ID!
  \$patientId: ID!
  \$reservationId: ID!
  \$startTime: DateTime!
  \$note: String!
) {
  editReservation(
    id: \$reservationId
    data: {
      reserverId: 1
      patientId: \$patientId
      doctorId: \$doctorId
      workplaceId: \$workplaceId
      consultationId: \$consultationId
      note: \$note
      startTime: \$startTime
      endTime: \$startTime
      type: "online"
      status: "waiting"
    }
  ) {
    id
  }
}
  """;

  Widget getFlatBtn(String txt, Widget open, GraphQLClient gql, dynamic d) {
    return Padding(
      padding: EdgeInsets.only(left: 72, top: 5, bottom: 5),
      child: GestureDetector(
        child: InkWell(
            onTap: () {
              if (open == null) {
                setState(() {
                  _loading = true;
                });
                gql
                    .mutate(MutationOptions(document: ccd, variables: {
                  "workplaceId": d['workplace']['id'],
                  "doctorId": d['doctor']['id'],
                  "reservationId": d['id'],
                  "patientId": model.loggedInUserId,
                  "startTime": DateTime.now().toIso8601String()
                }))
                    .then((qr) {
                  var dv2 = qr.data['createConsultation']['id'];
                  gql
                      .mutate(MutationOptions(document: erd, variables: {
                    "workplaceId": d['workplace']['id'],
                    "doctorId": d['doctor']['id'],
                    "patientId": model.loggedInUserId,
                    "reservationId": d['id'],
                    "consultationId": dv2,
                    "startTime": DateTime.now().toIso8601String(),
                    "note": d['note']
                  }))
                      .then((qr2) {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                          return OnlineAppointmentDetails(id);
                        }));
                    setState(() {
                      _loading = false;
                    });
                  });
                });
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return open;
                }));
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                txt,
                style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
