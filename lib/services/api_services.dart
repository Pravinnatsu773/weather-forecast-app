import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/';

  final String currentWeather = 'weather';
  final String forecast = 'forecast';

  final String apiId = '<Your api id>';

  Future<Map<String, dynamic>> getData(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$endpoint&appid=$apiId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
