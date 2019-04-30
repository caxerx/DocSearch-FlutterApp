import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/ProfilePage.dart';
import 'package:doc_search/widget/SearchFilterPage.dart';
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
    id
    name
    specialty
    academic
    experience
    workplace {
      location
    }
    feedbacks{
      id
    }
  }
}
  """
        .replaceAll('\n', ' ');
  }

  GlobalModel m2;

  @override
  void initState() {
    super.initState();
    m2 = ScopedModel.of<GlobalModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalModel>(
        rebuildOnChange: true,
        builder: (b, w, m) {
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
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            SearchFilterPage()));
                              },
                            ),
                          ),
                          Visibility(
                            visible: m.language != "",
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                child: Chip(label: Text(m.language)),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              SearchFilterPage()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: m.specialty != "",
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                child: Chip(label: Text(m.specialty)),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              SearchFilterPage()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: m.location != "",
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                child: Chip(label: Text(m.location)),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              SearchFilterPage()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: m.gender != "",
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                child: Chip(
                                    label: Text(
                                        m.gender == "M" ? "Male" : "Female")),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              SearchFilterPage()));
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Query(
              options: QueryOptions(document: readRepositories, variables: {
                "keyword": m.keyword,
                "language": m.language,
                "specialty": m.specialty,
                "location": m.location,
                "gender": m.gender
              }),
              builder: (QueryResult rs) {
                if (rs.hasErrors) {
                  print(rs.errors);
                  return SliverList(
                      delegate: SliverChildListDelegate([Text("")]));
                }

                if (rs.loading) {
                  return SliverList(
                      delegate: SliverChildListDelegate([Text("")]));
                }
                var data = rs.data['searchDoctors'];
                return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, i) {
                      List fb = data[i]["feedbacks"];
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
                                      backgroundImage: (data[i]["avatar"] ==
                                                  null ||
                                              data[i]["avatar"] == "")
                                          ? AssetImage("assets/noavatar.png")
                                          : NetworkImage("https://dsapi.1lo.li/assets/avatars/"+data[i]["avatar"]),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                118,
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
                                            Text(fb.length.toString()+" Feedback"),
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
                                              builder: (context) =>
                                                  ProfilePage(data[i]['id'])));
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
        });
  }

  @override
  void dispose() {
    super.dispose();
    m2.gender = "";
    m2.location = "";
    m2.language = "";
    m2.specialty = "";
    print("STATE DESTROYED");
  }
}
