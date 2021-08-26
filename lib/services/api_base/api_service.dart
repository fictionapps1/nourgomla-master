import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class APIService {
  final API api = API();
  static var httpClient = http.Client();

  Future<Map<String, dynamic>> getData({
    @required Endpoints endpoint,
    Map headers,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await httpClient.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data;
      }
    }
    print(
      'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }

  Future<Map<String, dynamic>> postData({
    @required Endpoints endpoint,
    @required Map body,
  }) async {
    final uri = api.endpointUri(endpoint);

    final response = await http.post(uri, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    print(
      '*** Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }
}
