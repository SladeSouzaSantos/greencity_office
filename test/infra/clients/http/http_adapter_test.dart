import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client{}

class HttpAdapter{
  final Client client;

  HttpAdapter({required this.client});

  Future<void> request({
    required String url,
    required String method
  }) async{
    final headers = {
      'content-type' : 'application/json',
      'accept' : 'application/json'
    };
    await client.post(Uri.parse(url), headers: headers)!;
  }
}


void main(){
  late String url;
  ClientSpy? client;
  HttpAdapter? sut;

  setUp((){
    client = ClientSpy();
    sut = HttpAdapter(client: client!);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();

    registerFallbackValue(Uri.parse(url));
  });

  group("post", (){
    test("Deve chamar post com valores corretos.", () async{


      final headers = {
        'content-type' : 'application/json',
        'accept' : 'application/json'
      };

      when(() => client!.post!(any(), headers: headers))
          .thenAnswer((_) async => Response('{}', 200));

      await sut!.request!(url: url, method: "post");

      verify(() => client!.post!(
          Uri.parse(url),
          headers: {
            'content-type' : 'application/json',
            'accept' : 'application/json'
          }
      ));
    });
  });
}