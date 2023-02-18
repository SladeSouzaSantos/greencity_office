import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:greencity_sustentavel_office/domain/usecases/usecases.dart';

import 'package:greencity_sustentavel_office/application/http/http.dart';
import 'package:greencity_sustentavel_office/application/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient{}

void main(){

  RemoteAuthentication? sut;
  HttpClientSpy? httpClient;
  String? url;

  setUp((){
    httpClient = HttpClientSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient!, url: url!);
  });

  test("Deve chamar HttpClient com valores corretos.", () async{
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut!.auth(params: params);

    verify(httpClient!.request(
        url: url!,
        method: "post",
        body: {"email": params.email, "password" : params.password}
    ));
  });
}