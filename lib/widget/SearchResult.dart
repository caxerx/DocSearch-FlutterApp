import 'package:docsearch/widget/ProfilePage.dart';
import 'package:docsearch/widget/SearchFilterPage.dart';
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
                      child: GestureDetector(
                        child: Chip(
                          label: Text(
                            "Add Filters",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  SearchFilterPage()));
                        },
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
                                "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 118,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Dr. Chan Tai Man",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text("Dentist"),
                                  Text(
                                    "BDS, MDS - Oral Medicine and Radiology",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("13 years experience"),
                                  Text("Central District"),
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
