import 'dart:convert';
import 'dart:io';

import 'package:carros/domain/carro.dart';
import 'package:carros/domain/response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    final url = "http://livrowebservices.com.br/rest/carros/tipo/$tipo";

    final response = await http.get(url);
    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    return mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();
  }

  static Future<Response> salvar(Carro carro, File file) async {
    /*Valida se existe arquivo de imagem da câmera.*/
    if (file != null) {
      final fotoResponse = await upload(file);
      carro.urlFoto = fotoResponse.url;
    }

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

  static Future<Response> upload(File file) async {
    final url = "http://livrowebservices.com.br/rest/carros/postFotoBase64";
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = path.basename(file.path);
    var body = {"fileName": fileName, "base64": base64Image};
    final response = await http.post(url, body: body);
    Map<String, dynamic> map = json.decode(response.body);
    return Response.fromJson(map);
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
