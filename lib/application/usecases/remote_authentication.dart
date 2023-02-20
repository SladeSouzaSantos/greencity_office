import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../clients/clients.dart';
import '../models/models.dart';

class RemoteAuthentication{
  final ClientGeneric clientGeneric;
  final String? url;

  RemoteAuthentication(
      {
        required this.clientGeneric,
        this.url
      });

  Future<AccountEntity> auth({required AuthenticationParams params}) async{
    final body = RemoteAuthenticationParams.fromDomain(params: params).toJson();
    try{
      final clientGenericResponse = await clientGeneric.request(
          url: url,
          method: "post",
          body: body
      );
      return RemoteAccountModel.fromJson(clientGenericResponse!).toEntity();
    }on ClientError catch(error){
      throw error == ClientError.unauthorized
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