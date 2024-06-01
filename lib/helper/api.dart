import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> _makeRequest({
    required String url,
    required String method,
    dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    final uri = Uri.parse(url);
    http.Response response;

    switch (method) {
      case 'GET':
        log('GET: $url body: $body');
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        log('POST: $url body: $body ');
        response = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case 'PUT':
        log('PUT: $url body: $body');
        response = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      default:
        throw Exception('Invalid HTTP method');
    }

    if (response.statusCode == 200) {
      log('data: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'API Error: '
            'URL: $url'
            'Method: $method'
            'Status Code: ${response.statusCode}'
            'Response: ${response.body}',
      );
    }
  }

  Future<dynamic> get({required String url, String? token}) async {
    return _makeRequest(url: url, method: 'GET', token: token);
  }

  Future<dynamic> post({required String url, dynamic body, String? token}) async {
    return _makeRequest(url: url, method: 'POST', body: body, token: token);
  }

  Future<dynamic> put({required String url, dynamic body, String? token}) async {
    return _makeRequest(url: url, method: 'PUT', body: body, token: token);
  }
}