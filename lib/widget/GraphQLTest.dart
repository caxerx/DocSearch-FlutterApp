import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLTest extends StatelessWidget{
  ValueNotifier<Client> client;

  GraphQLTest(){
    client = ValueNotifier(
      Client(
        endPoint: 'https://dsapi.1lo.li/api/graphql',
        cache: InMemoryCache(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    String readRepositories = """
query{
  users {
    id,
    name,
  }
}
"""
        .replaceAll('\n', ' ');


    return GraphqlProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
      ),
    );
  }


}