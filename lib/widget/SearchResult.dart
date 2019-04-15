import 'package:docsearch/model/SearchModel.dart';
import 'package:docsearch/widget/ProfilePage.dart';
import 'package:docsearch/widget/SearchFilterPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recase/recase.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchResultPage extends StatefulWidget {
  @override
  State<SearchResultPage> createState() {
    return SearchResultPageState();
  }
}

class SearchResultPageState extends State<SearchResultPage> {
  SearchModel model;

  get readRepositories {
    return """
  query searchDoctor(\$keyword: String!, \$language: String!, \$specialty: String!, \$location: String!, \$gender: String!){
  searchDoctors(
    criteria: {
      search: \$keyword
      language: \$language
      specialty: \$specialty
      location: \$location
      gender: \$gender
    }
  ) {
    name
    specialty
    academic
    experience
    workplace {
      location
    }
  }
}
  """
        .replaceAll('\n', ' ');
  }

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<SearchModel>(context);
  }

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
      Query(
        options: QueryOptions(document: readRepositories, variables: {
          "keyword": model.keyword,
          "language": model.language,
          "specialty": model.specialty,
          "location": model.location,
          "gender": model.gender
        }),
        builder: (QueryResult rs) {
          if (rs.hasErrors) {
            print(rs.errors);
            return SliverList(delegate: SliverChildListDelegate([Text("")]));
          }

          if (rs.loading) {
            return SliverList(delegate: SliverChildListDelegate([Text("")]));          }
          var data = rs.data['searchDoctors'];
          return SliverList(
              delegate: SliverChildBuilderDelegate((ctx, i) {
            return Container(
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: (data[i]["avatar"] == null ||
                                        data[i]["avatar"] == "")
                                    ? AssetImage("assets/docsearch_logo.png")
                                    : NetworkImage(data[i]["avatar"]),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 118,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data[i]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(ReCase(data[i]["specialty"])
                                          .titleCase),
                                      Text(
                                        data[i]["academic"],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(data[i]["experience"] +
                                          " experience"),
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
            );
          }, childCount: data.length));
        },
      ),
    ]));
  }
}
