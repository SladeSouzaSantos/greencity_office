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
    await client.post(Uri.parse(url))!;
  }
}


void main(){
  late String url;

  setUpAll(() {
    url = faker.internet.httpUrl();

    registerFallbackValue(Uri.parse(url));
  });

  group("post", (){
    test("Deve chamar post com valores corretos.", () async{
      final client = ClientSpy();
      final sut = HttpAdapter(client: client);

      when(() => client.post(any()))
          .thenAnswer((_) async => Response('{}', 200));

      await sut!.request!(url: url, method: "post");

      verify(() => client.post(Uri.parse(url)));
    });
  });
}