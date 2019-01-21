import 'package:docsearch/widget/SearchResult.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  var searchHistory = <String>[
    "Transgender",
    "Dentist",
    "Ear-nose-throat",
    "Chan Tai Man",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 125,
        pinned: true,
        title: Text("Search a Doctor"),
        flexibleSpace: FlexibleSpaceBar(
          background: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
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
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 15,
          ),
          color: Colors.black12,
          child: Row(
            children: <Widget>[
              Text(
                "Search History",
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: FlatButton(
                  child: Text("CLEAR"),
                  onPressed: () {
                    setState(() {
                      searchHistory.clear();
                    });
                  },
                ),
              )
            ],
          ),
        )
      ])),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: <Widget>[
              Divider(
                height: 1,
              ),
              ListTile(
                title: Text(searchHistory[index]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResultPage()));
                },
              ),
            ],
          );
        }, childCount: searchHistory.length),
      )
    ]));
  }
}
