import 'package:doc_search/widget/platform/VideoView.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class VideoConsultationPageState extends State<VideoConsultationPage> {
  var videoView;
  var viewCtrl;

  @override
  void initState() {
    super.initState();
    videoView = VideoView(onVideoViewCreated: (controller) {
      viewCtrl = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //_inCalling
              child: Builder(builder: (ctx) {
                return videoView;
              }),
              color: Colors.black,
            ),
          ),
          ExpandablePanel(
            initialExpanded: true,
            header: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Chat",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            expanded: SizedBox.fromSize(
              size: Size.fromHeight(MediaQuery.of(context).size.height * 0.45),
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Dr. Michael Wang: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long Msg So Long"),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 1)
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Me: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text("OK"),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 1)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  TextField(
                      decoration: InputDecoration(
                          hintText: "Input Message",
                          contentPadding: EdgeInsets.all(20.0)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoConsultationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoConsultationPageState();
  }
}
