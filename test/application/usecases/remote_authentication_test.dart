import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:greencity_sustentavel_office/domain/helpers/helpers.dart';
import 'package:greencity_sustentavel_office/domain/usecases/usecases.dart';
import 'package:greencity_sustentavel_office/application/clients/clients.dart';
import 'package:greencity_sustentavel_office/application/usecases/usecases.dart';

class ClientGenericSpy extends Mock implements HttpClient{}

void main(){

  late RemoteAuthentication sut;
  late ClientGenericSpy clientGeneric;
  late String url;
  late AuthenticationParams params;

  Map mockValidData() => {"accessToken" : faker.guid.guid(), "name" : faker.person.name()};

  When mockRequest() =>
      when(() => clientGeneric.request(url: any(named: "url"), method: any(named: "method"), body: any(named: "body")));

  void mockClientGenericData(Map data){
    return mockRequest().thenAnswer((_) async => data);
  }

  void mockClientGenericError(ClientError error){
    return mockRequest().thenThrow(error);
  }

  setUp((){
    clientGeneric = ClientGenericSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(clientGeneric: clientGeneric, url: url);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    mockClientGenericData(mockValidData());
  });

  test("Deve chamar ClientGeneric com valores corretos.", () async{
    await sut.auth(params: params);

    verify(() => clientGeneric.request(
        url: url,
        method: "post",
        body: {"email": params.email, "password" : params.password}
    ));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 400.", () async{
    mockClientGenericError(ClientError.badRequest);
    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 404.", () async{
    mockClientGenericError(ClientError.notFound);
    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 500.", () async{
    mockClientGenericError(ClientError.serverError);
    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Deve chamar invalidCredentialsError quando ClientGeneric retornar 401.", () async{
    mockClientGenericError(ClientError.unauthorized);
    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.invalidCredentialsError));
  });

  test("Deve retornar um Account quando ClientGeneric retornar 200.", () async{
    final validData = mockValidData();
    mockClientGenericData(validData);

    final account = await sut.auth(params: params);

    expect(account.token, validData["accessToken"]);
  });

  test("Deve chamar UnexpectedError quando ClientGeneric retornar 200 com dados inválidos.", () async{

    mockClientGenericData({"invalid_key" : "invalid_value"});

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });
}