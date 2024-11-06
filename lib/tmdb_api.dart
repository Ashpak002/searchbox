import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBApi {
  final String apiKey = 'aaee2061a81f6c3562d218338932722b';

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> searchTVShows(String query) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load TV shows');
    }
  }
}
