import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:praktikum_disney/API_Model/api_disney_model.dart';

class ApiService {
  static const String CharacterApiUrl = 'https://api.disneyapi.dev/character';

  static Future<List<Data>> fetchCharacter() async {
    final response = await http.get(Uri.parse(CharacterApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Data.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load character');
    }
  }
}
