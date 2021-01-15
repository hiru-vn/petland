import 'dart:async';

import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:graphql/client.dart';
import 'package:petland/share/import.dart';

class BaseService {
  String _module;
  String _name;
  String _fragmentDefault;

  BaseService({String module, String fragment}) {
    print(module);
    _module = module;
    _name = capitalizeModule();
    _fragmentDefault = parseFragment(fragment);
  }

  capitalizeModule() {
    return '${_module[0].toUpperCase()}${_module.substring(1)}';
  }

  showModule() {
    print('module $_module');
    print('Fragment $_fragmentDefault');
    print('Name $_name');
  }

  parseFragment(String fragment) {
    final a = fragment.split('\n');
    var resData = [];
    for (var item in a) {
      final b = item.split(':');
      resData = [...resData, b[0].replaceAll(' ', '')];
    }
    return resData.join(' ');
  }

  Future<dynamic> getList(
      {int limit,
      String filter,
      String search,
      String order,
      int page = 1,
      int offset,
      String fragment}) async {
    fragment = fragment ?? _fragmentDefault;
    if (filter == null) filter = "";
    if (search == null) search = "";
    final String listNode =
        'query GetAll$_name{getAll$_name(q:{limit: $limit, page: ${page ?? 1}, offset: $offset, filter: {$filter}, search: "$search" , order: $order }){data{$fragment} pagination{limit offset page total} }}';
    print("Query: " + listNode);

    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getAll$_name ${result.exception.toString()}');
      await showToastNoContext(
          result.exception.graphqlErrors[0].message.toString());
      if (result.exception.graphqlErrors[0].message ==
          "Mã truy cập đã hết hạn") {
        AuthBloc.instance.logout();
      }
      GraphQL.instance.client.cache.reset();
      throw (Exception(result.exception.graphqlErrors[0].message.toString()));
    }
    GraphQL.instance.client.cache.reset();
    print("getAll$_name : ${result.data['getAll$_name']}");
    return result.data['getAll$_name'];
  }

  Future<dynamic> getItem(String id, {String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String listNode =
        'query getItem{getOne$_name(id: "$id"){ $fragmentGetItem }}';

    print("Query: " + listNode);
    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getItem ${result.exception.toString()}');
      throw result.exception.graphqlErrors[0].message.toString();
    }
    print("getOne$_name : ${result.data['getOne$_name']}");
    GraphQL.instance.client.cache.reset();
    return result.data['getOne$_name'];
  }

  getInfo({String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String listNode =
        'query getItem{get${_name}Info{ $fragmentGetItem }}';

    print("Query: " + listNode);
    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getItem ${result.exception.toString()}');
      throw (Exception(result.exception.graphqlErrors[0].message.toString()));
    }
    print("get$_name : ${result.data['get${_name}Info']}");
    GraphQL.instance.client.cache.reset();
    return result.data['get${_name}Info'];
  }

  add(String data, {String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String addNode =
        'mutation { create$_name(data: {$data}) { $fragmentGetItem } }';
    print('addNode $addNode');
    final MutationOptions optionsAdd =
        MutationOptions(documentNode: gql(addNode));

    final QueryResult result = await GraphQL.instance.client.mutate(optionsAdd);
    if (result.hasException) {
      print('add$_name ${result.exception.toString()}');
      throw result.exception.graphqlErrors[0].message.toString();
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data['create$_name'];
  }

  Future delete(String id) async {
    final String deleteNode = 'mutation { deleteOne$_name(id: "$id") { id }}';
    final MutationOptions optionsDelete =
        MutationOptions(documentNode: gql(deleteNode));

    final QueryResult result =
        await GraphQL.instance.client.mutate(optionsDelete);
    if (result.hasException) {
      print('deleteOne$_name ${result.exception.toString()}');
      throw result.exception.graphqlErrors[0].message.toString();
    }

    GraphQL.instance.client.cache.reset();
    print('deleteOne$_name result.data');
    return result.data;
  }

  update({String id, String data, String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String deleteNode =
        'mutation { update$_name(id: "$id", data: {$data}) {$fragmentGetItem} }';
    print(deleteNode);
    final MutationOptions optionsDelete =
        MutationOptions(documentNode: gql(deleteNode));

    final QueryResult result =
        await GraphQL.instance.client.mutate(optionsDelete);
    if (result.hasException) {
      print('delete$_name ${result.exception.toString()}');
      throw result.exception.graphqlErrors[0].message.toString();
    }
    if (result.data['update$_name'] == null) {
      throw 'Id không tồn tại';
    }
    GraphQL.instance.client.cache.reset();
    print('update ${result.data['update$_name']['id']}');

    return result.data['update$_name'];
  }

  mutate(String name, String data, {String fragment}) async {
    String mutateNode;
    if (fragment == null)
      mutateNode = 'mutation { $name($data) }';
    else
      mutateNode = 'mutation { $name($data) { $fragment } }';
    print('MutateNode $mutateNode');

    final MutationOptions options =
        MutationOptions(documentNode: gql(mutateNode));

    final QueryResult result = await GraphQL.instance.client.mutate(options);
    if (result.hasException) {
      print('name ${result.exception.toString()}');
      throw (Exception(result.exception.graphqlErrors[0].message.toString()));
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data;
  }

  query(String name, String data, {String fragment}) async {
    String queryNode;
    if (fragment == null)
      queryNode = 'query { $name($data) }';
    else
      queryNode = 'query { $name($data) { $fragment } }';
    print('$queryNode');

    final MutationOptions options =
        MutationOptions(documentNode: gql(queryNode));

    final QueryResult result = await GraphQL.instance.client.mutate(options);
    if (result.hasException) {
      print('name ${result.exception.toString()}');
      throw (Exception(result.exception.graphqlErrors[0].message.toString()));
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data;
  }

  queryEnum(String name) async {
    String queryNode;
    queryNode = 'query { $name }';
    print('$queryNode');

    final MutationOptions options =
        MutationOptions(documentNode: gql(queryNode));

    final QueryResult result = await GraphQL.instance.client.mutate(options);
    if (result.hasException) {
      print('name ${result.exception.toString()}');
      throw (Exception(result.exception.graphqlErrors[0].message.toString()));
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data;
  }
}

class GraphQL {
  static final HttpLink _httpLink = HttpLink(
    uri: 'https://frozen-woodland-48252.herokuapp.com/graphql',
  );

  static final AuthLink _authLink = AuthLink(getToken: () async {
    final token = await SPref.instance.get('token');
    return token;
  });

  static final Link _link = _authLink.concat(_httpLink);
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
  GraphQL._internal();
  static final GraphQL instance = GraphQL._internal();

  GraphQLClient get client => _client;
}

//Set x-token to header

typedef GetToken = FutureOr<String> Function();

class AuthLink extends Link {
  AuthLink({
    this.getToken,
  }) : super(
          request: (Operation operation, [NextLink forward]) {
            StreamController<FetchResult> controller;

            Future<void> onListen() async {
              try {
                final String token = await getToken();
                operation.setContext(<String, Map<String, String>>{
                  'headers': <String, String>{'x-token': token}
                });
              } catch (error) {
                controller.addError(error);
              }
              await controller.addStream(forward(operation));
              await controller.close();
            }

            controller = StreamController<FetchResult>(onListen: onListen);
            return controller.stream;
          },
        );

  GetToken getToken;
}
