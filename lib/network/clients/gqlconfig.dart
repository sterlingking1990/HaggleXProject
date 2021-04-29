import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglexproject/network/clients/resend_verification_model.dart';
import 'package:hive/hive.dart';

const GQL_HAGGLEX_BASE_API =
    "https://hagglex-backend-staging.herokuapp.com/graphql";

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(GQL_HAGGLEX_BASE_API);

  Future<GraphQLClient> gQLConfig() async {
    var box =
        await Hive.openBox<ResendVerificationModel>('resendverificationmodel');

    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore(box)),
    );
  }
}
