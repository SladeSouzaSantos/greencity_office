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

  setUp((){
    clientGeneric = ClientGenericSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(clientGeneric: clientGeneric!, url: url!);
  });

  test("Deve chamar ClientGeneric com valores corretos.", () async{
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut!.auth(params: params);

    verify(clientGeneric!.request(
        url: url!,
        method: "post",
        body: {"email": params.email, "password" : params.password}
    ));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 400.", () async{
    when(clientGeneric!.request(url: anyNamed("url"), method: anyNamed("method"), body: anyNamed("body"))).thenThrow(HttpError.badRequest);
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    final future = sut!.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });
}