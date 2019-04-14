import 'package:docsearch/widget/AppointmentList.dart';
import 'package:docsearch/widget/LoginPage.dart';
import 'package:docsearch/widget/MedicalRecordListPage.dart';
import 'package:docsearch/widget/Search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  State<StatefulWidget> createState() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure();
    _firebaseMessaging.getToken().then((t) => print(t));
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _page = 0;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
          setState(() {
            _page = i;
          });
          if (i == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
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
        Container(
          padding: EdgeInsets.all(15),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Medical News",
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            "assets/docsearch_logo.png",
                            width: 128,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Title TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle TitleTitle Title",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title ",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "21/12/2019 - News Forward",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color:Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1,)
            ],
          ),
        )
      ],
    );
  }

  Widget getProfilePage() {
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
                      minRadius: 40,
                      maxRadius: 40,
                      backgroundImage: NetworkImage(
                          "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Caxer Tsang",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Username: caxerx",
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MedicalRecordListPage()));
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.feedback,
            size: 40,
          ),
          title: Text("Feedback"),
          subtitle: Text("Share opinions to the development team."),
        ),
      ],
    );
  }
}
