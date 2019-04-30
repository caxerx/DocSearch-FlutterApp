import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void VideoViewCreatedCallback(VideoViewController controller);

class VideoView extends StatefulWidget {
  const VideoView({
    Key key,
    this.onVideoViewCreated,
  }) : super(key: key);

  final VideoViewCreatedCallback onVideoViewCreated;

  @override
  State<StatefulWidget> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'li.a1lo.docsearch.doc_search/videoview',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the twilio video plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onVideoViewCreated == null) {
      return;
    }
    widget.onVideoViewCreated(new VideoViewController._(id));
  }
}

class VideoViewController {
  VideoViewController._(int id)
      : _channel =
            new MethodChannel('li.a1lo.docsearch.doc_search/videoview_$id');

  final MethodChannel _channel;

  Future<void> connectToRoom(String accessToken, String roomName) async {
    assert(accessToken != null);
    assert(roomName != null);
    return _channel.invokeMethod('connectToRoom',
        {"accessToken": accessToken, "roomName": roomName}).catchError((e) {
      print("OOPS> " + e.toString());
    });
  }

  Future<void> disconnectFromRoom() async {
    return _channel.invokeMethod(
      'disconnectFromRoom',
    );
  }
}
