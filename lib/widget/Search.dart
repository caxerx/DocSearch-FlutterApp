import 'dart:async';

import 'package:docsearch/model/SearchModel.dart';
import 'package:docsearch/widget/SearchResult.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  var _searchHistory = <String>[];
  var _keyword = new TextEditingController();
  var _focusNode = FocusNode();
  var model;

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of<SearchModel>(context);
    Future.delayed(Duration(milliseconds: 100),(){
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }


  void _getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var searchHistory = prefs.getStringList("searchHistory");
    if (searchHistory != null) {
      setState(() {
        _searchHistory = searchHistory;
      });
    }
  }

  void _addSearchHistory(keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_searchHistory.contains(keyword)) {
      _searchHistory.remove(keyword);
    }
    setState(() {
      _searchHistory.insert(0, keyword);
    });
    prefs.setStringList("searchHistory", _searchHistory);
  }

  void _clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory.clear();
    });
    prefs.setStringList("searchHistory", _searchHistory);
  }

  _search(keyword) async {
    model.keyword = keyword;
    _addSearchHistory(keyword);
    _keyword.text = "";
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchResultPage()));
  }



  @override
  Widget build(BuildContext context) {
    _getSearchHistory();
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
                focusNode: _focusNode,
                onSubmitted: _search,
                controller: _keyword,
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
                  onPressed: _clearSearchHistory,
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
                title: Text(_searchHistory[index]),
                onTap: () {
                  _search(_searchHistory[index]);
                },
              ),
            ],
          );
        }, childCount: _searchHistory.length),
      )
    ]));
  }
}
