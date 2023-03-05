import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/client_spy.dart';

import 'package:greencity_sustentavel_office/application/clients/clients.dart';
import 'package:greencity_sustentavel_office/infra/clients/clients.dart';

void main(){
  late String url;
  late ClientSpy client;
  late FirebaseHttpAdapter sut;

  setUp((){
    client = ClientSpy();
    sut = FirebaseHttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group("shared", () {
    test("Deve passar ServerError se metodo for invalido.", () async{
      final future = sut.request(url: url, method: "invalid_method");

      expect(future, throwsA(ClientError.serverError));
    });
  });

  group("post", (){

    test("Deve chamar post com valores corretos.", () async{
      await sut.request(url: url, method: "post", body: {"any_key" : "any_value"});

      verify(() => client.post(
          Uri.parse(url),
          headers: {
            'content-type' : 'application/json'
          },
        body: '{"any_key":"any_value","returnSecureToken":true}'
      ));
    });

    test("Deve chamar post sem body.", () async{
      await sut.request(url: url, method: "post");

      verify(() => client.post(
          any(),
          headers: any(named: "headers")
      ));
    });

    test("Deve retornar dados se post retornar 200.", () async{
      final response = await sut.request(url: url, method: "post");

      expect(response, {"any_key":"any_value"});
    });

    test("Deve retornar dados se post retornar 200 sem dados.", () async{
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Deve retornar null se post retornar 204.", () async{
      client.mockPost(204, body: '');

      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Deve retornar null se post retornar 204 com dados.", () async{
      client.mockPost(204);

      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Deve retornar BadRequestError se post retornar 400 sem dados.", () async{
      client.mockPost(400, body: '');

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.badRequest));
    });

    test("Deve retornar BadRequestError se post retornar 400.", () async{
      client.mockPost(400);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.badRequest));
    });

    test("Deve retornar UnauthorizedError se post retornar 401.", () async{
      client.mockPost(401);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.unauthorized));
    });

    test("Deve retornar ForbiddenError se post retornar 403.", () async{
      client.mockPost(403);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.forbidden));
    });

    test("Deve retornar NotFoundError se post retornar 404.", () async{
      client.mockPost(404);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.notFound));
    });

    test("Deve retornar ServerError se post retornar 500.", () async{
      client.mockPost(500);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.serverError));
    });

    test("Deve retornar ServerError se post retornar throws.", () async{
      client.mockError();

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(ClientError.serverError));
    });

  });
}