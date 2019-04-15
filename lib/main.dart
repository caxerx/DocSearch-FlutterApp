import 'package:docsearch/model/SearchModel.dart';
import 'package:docsearch/widget/DocSearchApp.dart';
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

  runApp(ScopedModel<SearchModel>(
    model: SearchModel(),
    child: GraphQLProvider(
      client: client,
      child: DocSearchApp(),
    ),
  ));
}
