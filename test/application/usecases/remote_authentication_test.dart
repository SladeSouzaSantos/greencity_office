import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:greencity_sustentavel_office/domain/helpers/helpers.dart';
import 'package:greencity_sustentavel_office/domain/usecases/usecases.dart';
import 'package:greencity_sustentavel_office/application/clients/clients.dart';
import 'package:greencity_sustentavel_office/application/usecases/usecases.dart';

class ClientGenericSpy extends Mock implements ClientGeneric{}

void main(){

  RemoteAuthentication? sut;
  ClientGenericSpy? clientGeneric;
  String? url;
  AuthenticationParams? params;

  setUp((){
    clientGeneric = ClientGenericSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(clientGeneric: clientGeneric!, url: url!);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
  });

  test("Deve chamar ClientGeneric com valores corretos.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenAnswer((_) async => {"accessToken" : faker.guid.guid(), "name" : faker.person.name()});

    await sut!.auth!(params: params!);

    verify(clientGeneric!.request!(
        url: url!,
        method: "post",
        body: {"email": params!.email, "password" : params!.password}
    ));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 400.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenThrow(ClientError.badRequest);
    final future = sut!.auth!(params: params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 404.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenThrow(ClientError.notFound);
    final future = sut!.auth!(params: params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 500.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenThrow(ClientError.serverError);
    final future = sut!.auth!(params: params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar invalidCredentialsError quando ClientGeneric retornar 401.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenThrow(ClientError.unauthorized);
    final future = sut!.auth!(params: params!);

    expect(future, throwsA(DomainError.invalidCredentialsError));
  });

  test("Deve retornar um Account quando ClientGeneric retornar 200.", () async{
    final accessToken = faker.guid.guid();

    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenAnswer((_) async => {"accessToken" : accessToken, "name" : faker.person.name()});

    final account = await sut!.auth!(params: params!);

    expect(account.token, accessToken);
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 200 com dados inválidos.", () async{

    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body")))
        .thenAnswer((_) async => {"invalid_key" : "invalid_value"});

    final future = sut!.auth!(params: params!);

    expect(future, throwsA(DomainError.unexpected));
  });
}