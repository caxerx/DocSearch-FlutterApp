import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/AppointmentConfirmationPage.dart';
import 'package:doc_search/widget/AppointmentList.dart';
import 'package:doc_search/widget/AppointmentTimeSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:scoped_model/scoped_model.dart';

class AppointmentDetailsPage extends StatefulWidget {
  String did;
  TimeSlot ts;
  String type;

  AppointmentDetailsPage(this.did, this.ts, this.type);

  @override
  State createState() {
    return AppointmentDetailsPageState(did, ts, type);
  }
}

class AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  String did;
  TimeSlot ts;
  String type;

  AppointmentDetailsPageState(this.did, this.ts, this.type);

  DateFormat dfd = DateFormat("MMM dd, yyyy");
  DateFormat dft = DateFormat("HH:mm");

  GlobalModel model;

  var ad = """
query(\$doctorId:ID!) {
  doctor(id: \$doctorId) {
    name
    avatar
    specialty
    workplace{
      id
    }
  }
}
""";

  var cr = """
  mutation (\$data: CreateReservationInput!) {
    createReservation(data: \$data) {
      id
    }
  }
""";

  bool _loading = false;

  var tctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (gql) {
      return ModalProgressHUD(
        child: Query(
          options: QueryOptions(document: ad, variables: {"doctorId": did}),
          builder: (data) {
            if (data.loading) {
              return ModalProgressHUD(
                child: Container(),
                inAsyncCall: true,
              );
            }

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
                              radius: 20,
                              backgroundImage: (data.data["doctor"]["avatar"] ==
                                          null ||
                                      data.data["doctor"]["avatar"] == "")
                                  ? AssetImage("assets/noavatar.png")
                                  : NetworkImage(
                                      "https://dsapi.1lo.li/assets/avatars/" +
                                          data.data["doctor"]["avatar"]),
                            ),
                            title: Text(data.data["doctor"]["name"]),
                            subtitle: Text(
                                ReCase(data.data["doctor"]["specialty"])
                                    .titleCase),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text("Date"),
                            subtitle: Text(dfd.format(ts.start)),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text("Time"),
                            subtitle: Text(dft.format(ts.start)),
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
                            title: Text("Remark"),
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: TextField(
                              controller: tctrl,
                              decoration: InputDecoration(),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                            ),
                          ),
                        ])),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: RaisedButton(
                      child: Text("Done"),
                      onPressed: () {
                        setState(() {
                          _loading = true;
                        });

                        gql
                            .mutate(MutationOptions(document: cr, variables: {
                          "data": {
                            "doctorId": did,
                            "patientId": model.loggedInUserId,
                            "workplaceId": data.data["doctor"]["workplace"]
                                ["id"],
                            "reserverId": "1",
                            "note": tctrl.text,
                            "status": "pending",
                            "type": type,
                            "startTime": ts.start.toIso8601String(),
                            "endTime": ts.end.toIso8601String()
                          }
                        }))
                            .then((data) {
                          setState(() {
                            _loading = false;
                          });

                          while (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentConfirmationPage()));
                        });
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        inAsyncCall: _loading,
      );
    });
  }
}
