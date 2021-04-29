import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglexproject/model/request/ResendVerificationCode.dart';
import 'package:hagglexproject/model/response/ResendVerificationResponse.dart';
import 'package:hagglexproject/network/clients/gqlconfig.dart';
import 'package:hagglexproject/network/clients/queries.dart';
import 'package:rxdart/rxdart.dart';

class ResendVerificationState {
  final Queries queries = Queries();

  final GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  final PublishSubject<ResendVerificationResponse> _resendVerificationResponse =
      PublishSubject();

  Future resendVerificationCode(
      ResendVerificationCode resendVerificationCode) async {
    GraphQLClient graphQLClient = await graphQLConfiguration.gQLConfig();

    QueryResult queryResult = await graphQLClient.query(QueryOptions(
        document: gql(queries.resendVerificationCode()),
        variables: {'data': resendVerificationCode.toJson()}));

    if (queryResult != null) {
      if (queryResult.data != null) {
        _resendVerificationResponse.sink
            .add(ResendVerificationResponse.fromJson(queryResult.data));
      } else {
        _resendVerificationResponse.sink.add(
            ResendVerificationResponse.withError(
                queryResult.exception.graphqlErrors[0].message));
      }
    } else {
      _resendVerificationResponse.sink.add(ResendVerificationResponse.withError(
          "Could not complete registration, No Internet or unknown error"));
    }
  }

  dispose() {
    _resendVerificationResponse.close();
  }

  PublishSubject<ResendVerificationResponse>
      get resendVerificationCodeResponseObservable =>
          _resendVerificationResponse.stream;
}

final resendVerificationState = ResendVerificationState();
