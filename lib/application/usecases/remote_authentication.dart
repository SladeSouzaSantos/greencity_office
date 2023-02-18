import '../http/http_client.dart';

import '../../domain/usecases/usecases.dart';

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication(
      {
        required this.httpClient,
        required this.url
      });

  Future<void> auth({required AuthenticationParams params}) async{
    await httpClient.request(
        url: url,
        method: "post",
        body: RemoteAuthenticationParams.fromDomain(params: params).toJson()
    );
  }

}

class RemoteAuthenticationParams{
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain({required AuthenticationParams params}) =>
      RemoteAuthenticationParams(email: params.email, password: params.password);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}