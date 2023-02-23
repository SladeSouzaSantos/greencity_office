import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/client_spy.dart';

class HttpAdapter{
  final Client client;

  HttpAdapter({required this.client});

  Future<void> request({
    String? url,
    String? method,
    Map? body
  }) async{
    final headers = {
      'content-type' : 'application/json',
      'accept' : 'application/json'
    };
    await client.post(Uri.parse(url!), headers: headers, body: jsonEncode(body));
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
  });
}