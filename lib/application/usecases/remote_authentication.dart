import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../clients/clients.dart';

class RemoteAuthentication{
  final ClientGeneric clientGeneric;
  final String? url;

  RemoteAuthentication(
      {
        required this.clientGeneric,
        this.url
      });

  Future<void> auth({required AuthenticationParams params}) async{
    final body = RemoteAuthenticationParams.fromDomain(params: params).toJson();
    try{
      await clientGeneric.request(
          url: url,
          method: "post",
          body: body
      );
    }on HttpError catch(error){
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentialsError
          : DomainError.unexpected;
    }

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