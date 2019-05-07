import 'dart:convert';
import 'package:carros/domain/carro.dart';
import 'package:http/http.dart' as http;

class CarroService {
  static Future<List<Carro>> getCarros() async {
    final url = "http://livrowebservices.com.br/rest/carros";

    final response = await http.get(url);
    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    return mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();
  }
}
