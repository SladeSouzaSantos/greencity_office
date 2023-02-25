import 'dart:convert';

import 'package:http/http.dart';

import '../../../application/clients/clients.dart';

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

    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(Uri.parse(url!), headers: headers, body: jsonBody);

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