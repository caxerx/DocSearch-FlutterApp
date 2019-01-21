import 'package:docsearch/widget/ProfilePage.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  @override
  State<SearchResultPage> createState() {
    return SearchResultPageState();
  }
}

class SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 110,
        pinned: true,
        title: Text("Search Result"),
        flexibleSpace: FlexibleSpaceBar(
          background: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Chip(label: Text("Available")),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Chip(label: Text("Online Booking")),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Chip(label: Text("District")),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(
                          "Add Filters",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Container(
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                "https://movies4maniacs.liberty.me/wp-content/uploads/sites/1218/2015/09/avatarsucks.jpg"),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Dr. Avatar",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text("Gynecologist/Obstetrician"),
                                  Text("MBBS, MS - Obstetrics & Gynaecology"),
                                  Text("10 years experience"),
                                  Text("Shatin"),
                                ],
                              ))
                        ],
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: OutlineButton(
                          child: Text("View Profile"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                        ),
                      ),
                    ],
                  ))),
        )
      ]))
    ]));
  }
}
