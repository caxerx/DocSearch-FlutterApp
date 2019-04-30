import 'package:doc_search/model/GlobalModel.dart';
import 'package:doc_search/widget/DocSearchApp.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final Link link = HttpLink(
    uri: 'https://dsapi.1lo.li/api/graphql',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );

  var model = GlobalModel();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  _firebaseMessaging.configure();

  model.fcm = _firebaseMessaging;

  _firebaseMessaging.getToken().then((t) => model.token = t);

  runApp(ScopedModel<GlobalModel>(
    model: model,
    child: GraphQLProvider(
      client: client,
      child: DocSearchApp(),
    ),
  ));
}
