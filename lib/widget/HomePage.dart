import 'package:docsearch/widget/AppointmentList.dart';
import 'package:docsearch/widget/LoginPage.dart';
import 'package:docsearch/widget/MedicalRecordListPage.dart';
import 'package:docsearch/widget/Search.dart';
import 'package:docsearch/widget/components/ListHeader.dart';
import 'package:docsearch/widget/components/MedicalInfoTile.dart';
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
