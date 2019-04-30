import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/AppointmentList.dart';
import 'package:doc_search/widget/LoginPage.dart';
import 'package:doc_search/widget/MedicalRecordListPage.dart';
import 'package:doc_search/widget/Search.dart';
import 'package:doc_search/widget/components/ListHeader.dart';
import 'package:doc_search/widget/components/MedicalInfoTile.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _page = 0;
  FocusNode focusNode = FocusNode();
  GlobalModel model;

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<GlobalModel>(context);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
        focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DocSearch"),
        elevation: _page == 0 ? 0 : 4,
      ),
      body: Builder(
        builder: (context) {
          if (_page == 0) {
            return getHomeList();
          } else {
            return getProfilePage();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          if (i == 1 && model.loggedInUserId == "-1") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            setState(() {
              _page = i;
            });
          }
        },
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Profile"))
        ],
      ),
    );
  }

  Widget getHomeList() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        ListHeader("Medical News"),
        Expanded(
            child: ListView(children: <Widget>[
              MedicalInfoTile(
                  "https://filedrop.1lo.li/s2.png",
                  "Proper Breathing Brings Better Health",
                  "Strees reduction, insomnia prevention, emotional control, improved attention - certain breathiung techniques can make life better.",
                  "Jan 15, 2019",
                  "Christophe Andre"),
              Divider(
                height: 1,
              ),
              MedicalInfoTile(
                  "https://filedrop.1lo.li/s1.png",
                  "Pesticides on Our plates: Is Our Food Safe to Eat?",
                  "A new report looks at the amount of pesticides that are making their way to our plates",
                  "Jan 19, 2019",
                  "Nutrition Diva Monica Reinagel"),
              Divider(
                height: 1,
              ),
              MedicalInfoTile(
                  "https://filedrop.1lo.li/s3.png",
                  "A New Idea about What Trigger Alzheimer's ",
                  "Changes in brain celles' DNA may be reponsible - and if so, medicines already devveloped for other diseasess might be used to treat it.",
                  "Jan 9, 2019",
                  "Jerold Chun"),
              Divider(
                height: 1,
              ),
            ])),
      ],
    );
  }

  Widget getProfilePage() {
    var qd = """
query(\$id: ID!){
  patient(id: \$id){
    avatar
    name
    username
  }
}
    """;
    return Query(
      options: QueryOptions(
          document: qd, variables: {"id": model.loggedInUserId}),
      builder: (res) {
        return ModalProgressHUD(
          inAsyncCall: res.loading,
          child: Builder(builder: (ctx){
            if(res.loading) return Container();
            return ListView(
              children: <Widget>[
                GestureDetector(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              maxRadius: 40,
                              minRadius: 40,
                              backgroundImage: (res.data["patient"]["avatar"] ==
                                  null ||
                                  res.data["patient"]["avatar"] == "")
                                  ? AssetImage(
                                  "assets/noavatar.png")
                                  : NetworkImage(
                                  "https://dsapi.1lo.li/assets/avatars/" +
                                      res.data["patient"]["avatar"]),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    res.data["patient"]["name"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Username: ${res.data["patient"]["username"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.keyboard_arrow_right),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.check_box,
                    size: 40,
                  ),
                  title: Text("Appointment"),
                  subtitle: Text("View and manage the reserved services"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AppointmentList()));
                  },
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.assignment,
                    size: 40,
                  ),
                  title: Text("Medical Records"),
                  subtitle: Text("View the medical records"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalRecordListPage()));
                  },
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 40,
                  ),
                  title: Text("Logout"),
                  subtitle: Text("Logout from the device"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text("Are you sure to logout DocSearch"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  setState(() {
                                    model.loggedInUserId = "-1";
                                    _page = 0;
                                  });
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
