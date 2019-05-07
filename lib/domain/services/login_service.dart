import 'dart:convert';

import 'package:carros/domain/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Response> login(String login, String passws) async {
    var url = 'http://livrowebservices.com.br/rest/login';
    final response =
        await http.post(url, body: {'login': login, 'senha': passws});
    return Response.fromJson(json.decode(response.body));
  }
}
