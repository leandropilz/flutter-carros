import 'dart:convert';
import 'dart:io';

import 'package:carros/domain/response.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import '../user.dart';

class LoginService {
  static Future<Response> login(String login, String passws) async {
    //Valida a conexão com a internet pelo.
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return Response(false, "Internet indisponível");
    }

    try {
      var url = 'http://livrowebservices.com.br/rest/login';
      final response =
          await http.post(url, body: {'login': login, 'senha': passws});

      final resp = Response.fromJson(json.decode(response.body));
      if (resp.isOk()) {
        final user = User(
          "Leandro Pilz",
          login,
          "leandro.pilzz@gmail.com",
        );
        user.save();
      }
      return resp;
    } catch (error) {
      return Response(false, handleError(error));
    }
  }

  static String handleError(error) {
    return error is SocketException
        ? "Internet indisponível. Por vafor, verifique a sua conexão"
        : "Ocorreu um erro no login.";
  }
}
