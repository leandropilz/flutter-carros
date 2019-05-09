import 'dart:convert';
import 'package:carros/domain/carro.dart';
import 'package:carros/domain/response.dart';
import 'package:http/http.dart' as http;

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    final url = "http://livrowebservices.com.br/rest/carros/tipo/$tipo";

    final response = await http.get(url);
    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    return mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();
  }

  static Future<Response> salvar(Carro carro) async {
    final url = "http://livrowebservices.com.br/rest/carros";
    final headers = {"Content-Type": "application/json"};
    final body = json.encode(carro.toMap());
    final response = await http.post(url, headers: headers, body: body);
    return Response.fromJson(json.decode(response.body));
  }

  static Future<Response> excluir(int id) async {
    final url = "http://livrowebservices.com.br/rest/carros/$id";
    final response = await http.delete(url);
    return Response.fromJson(json.decode(response.body));
  }

  static Future<String> getLoremIpsum() async {
    final url = "https://loripsum.net/api";
    final response = await http.get(url);
    var body = response.body;
    body = body.replaceAll("<p>", "");
    body = body.replaceAll("</p>", "");
    return body;
  }
}
