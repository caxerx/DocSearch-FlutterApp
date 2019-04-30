import 'dart:convert';

import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/AppointmentTimeSelectionPage.dart';
import 'package:doc_search/widget/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating/flutter_rating.dart';

//

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() {
    return ProfilePageState(doc);
  }

  String doc;

  ProfilePage(this.doc);
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  Future<dynamic> fetchLoc(location) async {
    var resp = await http.get(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeQueryComponent(location)}&key=AIzaSyCkKfWny99Hef150nPJULVQx4MUXwDbe7w');
    return json.decode(resp.body);
  }

  GlobalModel model;
  List<Tab> tabs = <Tab>[
    Tab(text: 'Profile'),
    Tab(text: 'Service'),
    Tab(text: 'Feedback'),
  ];

  TabController _tabController;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          tab = _tabController.index;
        });
      }
    });
  }

  var queryProfile = """ 
query(\$doctorId: ID!) {
  doctor(id: \$doctorId) {
     name
    avatar
    academic
    averageRating
    specialty
    experience
    workplace {
      name
      location
    }
    timeSlots {
      weekday
      start
      end
    }
    services {
      name
    }
    feedbacks {
      postTime
      patient {
        name
      }
      rating
      comment
    }
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options:
          QueryOptions(document: queryProfile, variables: {"doctorId": doc}),
      builder: (data) {
        return ModalProgressHUD(
          inAsyncCall: data.loading,
          child: Builder(
            builder: (ctx) {
              if (data.loading) {
                return Container();
              }
              var d = data.data["doctor"];
              return DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      body: Column(
                    children: <Widget>[
                      Expanded(
                        child: CustomScrollView(slivers: <Widget>[
                          SliverAppBar(
                            bottom:
                                TabBar(tabs: tabs, controller: _tabController),
                            expandedHeight: 190,
                            pinned: true,
                            title: Text("Doctor Profile"),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        right: 10,
                                        left: 10,
                                        bottom: 50),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: (d["avatar"] ==
                                                      null ||
                                                  d["avatar"] == "")
                                              ? AssetImage(
                                                  "assets/noavatar.png")
                                              : NetworkImage(
                                                  "https://dsapi.1lo.li/assets/avatars/" +
                                                      d["avatar"]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  d["name"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                  d["academic"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  new ReCase(d["specialty"])
                                                      .titleCase,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(child: Builder(
                            builder: (ctx) {
                              if (tab == 0) {
                                return profilePage(d);
                              }
                              if (tab == 1) {
                                return servicePage(d);
                              }
                              if (tab == 2) {
                                return feedbackPage(d);
                              }
                              return Container();
                            },
                          )),
                        ]),
                      ),
                      Divider(height: 1),
                      ListTile(
                        title: OutlineButton(
                          child: Text("Book Appointment"),
                          onPressed: () {
                            if (model.loggedInUserId == "-1") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                              return;
                            }
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return getConsultationTypeSelector();
                                });
                          },
                        ),
                      )
                    ],
                  )));
            },
          ),
        );
      },
    );
  }

  Widget feedbackPage(data) {
    var fb = data["feedbacks"];
    print(fb);
    return Column(
      children: List.generate(fb.length, (i) {
        return Column(
          children: <Widget>[
            ListTile(
                title: Row(children: <Widget>[
                  Text(fb[i]['patient']['name']),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  StarRating(
                    rating: double.parse(fb[i]['rating'].toString()),
                    size: 15,
                  )
                ]),
                subtitle: Text(fb[i]['comment'] ?? "")),
            Divider(height: 1)
          ],
        );
      }),
    );
  }

  Widget servicePage(data) {
    var srv = data["services"];
    return Column(
      children: List.generate(srv.length, (i) {
        return Column(
          children: <Widget>[
            ListTile(title: Text(srv[i]['name'] ?? "")),
            Divider(height: 1)
          ],
        );
      }),
    );
  }

  Widget profilePage(data) {
    var wp = data["workplace"];
    var ts = data["timeSlots"];
    var sv = data["services"];
    var fv = data["feedbacks"];

    Map<String, List<String>> tm = new Map<String, List<String>>();

    for (var t in ts) {
      var wd = t['weekday'];
      if (!tm.containsKey(wd)) {
        tm[wd] = new List<String>();
      }
      tm[wd].add(t['start']);
      tm[wd].add(t['end']);
      tm[wd].sort();
    }

    Map<String, String> td = new Map<String, String>();
    for (var d in tm.keys) {
      var vts = tm[d];
      if (tm.length >= 2) {
        td[d] = "${vts[0]} - ${vts[vts.length - 1]}";
      }
    }

    return Column(children: [
      ListTile(
        leading: Icon(Icons.work),
        title: Text((data["experience"] ?? "") + " experience"),
      ),
      Divider(
        height: 1,
      ),
      GestureDetector(
        child: InkWell(
          onTap: () {
            launch(
                "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(wp["location"])}");
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(wp["name"]),
                subtitle: Text(wp["location"]),
              ),
              FutureBuilder<dynamic>(
                future: fetchLoc((wp["location"])),
                builder: (ctx, data) {
                  print(data.data);
                  if (data.connectionState == ConnectionState.done &&
                      data.data['status'] == "OK") {
                    var loc = data.data['results'][0]['geometry']['location'];
                    var lat = loc['lat'];
                    var lng = loc['lng'];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, left: 72, right: 15),
                      child: Image.network(
                        "https://maps.googleapis.com/maps/api/staticmap?center=${lat},${lng}&markers=color:red%7C${lat},${lng}&zoom=13&size=700x150&key=AIzaSyCkKfWny99Hef150nPJULVQx4MUXwDbe7w&scale=2",
                        fit: BoxFit.cover,
                        width: 400,
                        height: 150,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 10, top: 10, left: 72, right: 15),
                    child: SizedBox.fromSize(size: Size(400, 150)),
                  );
                },
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 1,
      ),
      GestureDetector(
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text("Open Time"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 72, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mon",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Tue",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Wed",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Thu",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Fri",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sat",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sun",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                td['mon'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['tue'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['wed'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['thu'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['fri'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['sat'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                td['sun'] ?? "Closed",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }

  Widget getConsultationTypeSelector() {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Select Appointment Type"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Clinic Consultation"),
                  subtitle: Text("Meet doctor in clinic."),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AppointmentTimeSelectionPage(doc, "clinic")));
                  },
                ),
                ListTile(
                  title: Text("Online Consultation"),
                  subtitle: Text("Meet doctor through online consultation."),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AppointmentTimeSelectionPage(doc, "online")));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String doc;

  ProfilePageState(this.doc);
}
