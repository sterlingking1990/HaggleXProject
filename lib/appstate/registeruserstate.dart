import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglexproject/model/request/RegisterUser.dart';
import 'package:hagglexproject/model/response/RegistrationResponse.dart';
import 'package:hagglexproject/network/clients/gqlconfig.dart';
import 'package:hagglexproject/network/clients/mutations.dart';
import 'package:rxdart/rxdart.dart';

class RegisterUserState {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  Mutations mutations = Mutations();

  final PublishSubject<RegistrationResponse> _registrationState =
      PublishSubject();

  Future registerUser(RegisterUser registerUser) async {
    GraphQLClient graphQLClient = await graphQLConfiguration.gQLConfig();

    QueryResult queryResult = await graphQLClient.mutate(MutationOptions(
        document: gql(mutations.registerUser()),
        variables: {'data': registerUser.toJson()}));

    print("error is ${queryResult.exception.graphqlErrors}");
    print(queryResult.data);
    if (queryResult != null) {
      if (queryResult.data != null) {
        _registrationState.sink
            .add(RegistrationResponse.fromJson(queryResult.data));
      } else {
        _registrationState.sink.add(RegistrationResponse.withError(
            queryResult.exception.graphqlErrors[0].message));
      }
    } else {
      _registrationState.sink.add(RegistrationResponse.withError(
          "Could not complete registration, No Internet or unknown error"));
    }
  }

  dispose() {
    _registrationState.close();
  }

  PublishSubject<RegistrationResponse> get registrationStateObservable =>
      _registrationState.stream;
}

final registerUserState = RegisterUserState();
