import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:greencity_sustentavel_office/application/clients/clients.dart';

import '../mocks/client_spy.dart';

class HttpAdapter implements ClientGeneric{
  final Client client;

  HttpAdapter({required this.client});

  @override
  Future<Map?> request({
    String? url,
    String? method,
    Map? body
  }) async{
    final headers = {
      'content-type' : 'application/json',
      'accept' : 'application/json'
    };
    final response = await client.post(Uri.parse(url!), headers: headers, body: body != null ? jsonEncode(body) : null);

    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}


void main(){
  late String url;
  late ClientSpy client;
  late HttpAdapter sut;

  setUp((){
    client = ClientSpy();
    sut = HttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group("post", (){

    test("Deve chamar post com valores corretos.", () async{
      await sut.request(url: url, method: "post", body: {"any_key" : "any_value"});

      verify(() => client.post(
          Uri.parse(url),
          headers: {
            'content-type' : 'application/json',
            'accept' : 'application/json'
          },
        body: '{"any_key":"any_value"}'
      ));
    });

    test("Deve chamar post sem body.", () async{
      await sut.request(url: url, method: "post");

      verify(() => client.post(
          any(),
          headers: any(named: "headers")
      ));
    });

    test("Deve retornar dados se post returnar 200.", () async{
      final response = await sut.request(url: url, method: "post");

      expect(response, {"any_key":"any_value"});
    });

    test("Deve retornar dados se post returnar 200 sem dados.", () async{
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

    test("Deve retornar null se post returnar 204.", () async{
      client.mockPost(204, body: '');

      final response = await sut.request(url: url, method: "post");

      expect(response, null);
    });

  });
}