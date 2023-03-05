import 'dart:convert';

import 'package:http/http.dart';

import '../../../application/clients/clients.dart';

class FirebaseHttpAdapter implements HttpClient{
  final Client client;

  FirebaseHttpAdapter({required this.client});

  @override
  Future<Map?> request({
    required String? url,
    required String? method,
    Map? body
  }) async{
    final headers = {
      'content-type' : 'application/json',
      //'accept' : 'application/json'
    };

    final String? jsonBody;

    if(body != null){
      body.addAll({"returnSecureToken":true});

      jsonBody = jsonEncode(body);
    }else {
      jsonBody = null;
    }

    var response = Response('', 500);

    try {
      if (method == 'post') {
        response = await client.post(
            Uri.parse(url!), headers: headers, body: jsonBody);
      }
    }catch(error){
      throw ClientError.serverError;
    }

    return _handleResponse(response: response);
  }

  Map? _handleResponse({required Response response}){
    if(response.statusCode == 200){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }else if(response.statusCode == 204){
      return null;
    }else if(response.statusCode == 400){
      throw ClientError.badRequest;
    }else if(response.statusCode == 401){
      throw ClientError.unauthorized;
    }else if(response.statusCode == 403){
      throw ClientError.forbidden;
    }else if(response.statusCode == 404){
      throw ClientError.notFound;
    }else{
      throw ClientError.serverError;
    }

  }
}