import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://official-joke-api.appspot.com";

  // Fetch the joke types
  Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));

    if (response.statusCode == 200) {
      List<dynamic> types = json.decode(response.body);
      return types.map((type) => type.toString()).toList();
    } else {
      throw Exception("Failed to load joke types");
    }
  }

  // Fetch jokes by type
  Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      List<dynamic> jokes = json.decode(response.body);
      return jokes.map((joke) => joke as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to load jokes of type: $type");
    }
  }

  // Fetch a random joke
  Future<Map<String, dynamic>> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load random joke");
    }
  }
}
