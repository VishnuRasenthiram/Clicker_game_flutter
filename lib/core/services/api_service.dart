import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class ApiService {

  final String baseUrl = Config.baseUrl;

  Future<dynamic> getRequest(String fichierPhp, {Map<String, String>? queryParams}) async {


    Uri url = Uri.parse('$baseUrl/$fichierPhp').replace(queryParameters: queryParams);


    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }

  Future<dynamic> postRequest(String fichierPhp, Map<String, dynamic> data) async {
    Uri url = Uri.parse('$baseUrl/$fichierPhp');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }

  Future<dynamic> deleteRequest(String endpoint, int id) async {
    Uri url = Uri.parse('$baseUrl/$endpoint?id=$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }
  Future<dynamic> updateRequest(String endpoint, int id, Map<String, dynamic> data) async {
    Uri url = Uri.parse('$baseUrl/$endpoint?id=$id');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }
}