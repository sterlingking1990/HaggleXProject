import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglexproject/model/request/LoginUser.dart';
import 'package:hagglexproject/model/response/LoginResponse.dart';
import 'package:hagglexproject/network/clients/gqlconfig.dart';
import 'package:hagglexproject/network/clients/mutations.dart';
import 'package:rxdart/rxdart.dart';

class LoginState {
  final PublishSubject<LoginResponse> _loginState = PublishSubject();
  final Mutations mutations = Mutations();
  final GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  Future loginUser(LoginInput loginInput) async {
    GraphQLClient graphQLClient = await graphQLConfiguration.gQLConfig();

    QueryResult queryResult = await graphQLClient.mutate(MutationOptions(
        document: gql(mutations.loginUser()),
        variables: {'data': loginInput.toJson()}));

    if (queryResult != null) {
      try {
        _loginState.sink.add(LoginResponse.fromJson(queryResult.data));
      } catch (error) {
        _loginState.sink.add(LoginResponse.withError(
            queryResult.exception.graphqlErrors[0].message));
      }
    }
  }

  dispose() {
    _loginState.close();
  }

  PublishSubject<LoginResponse> get loginStateObservable => _loginState.stream;
}

final loginState = LoginState();
