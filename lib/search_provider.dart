import 'package:flutter/material.dart';
import 'package:applestoreui/tmdb_api.dart';

class SearchProvider extends ChangeNotifier {
  List<dynamic> _results = [];
  bool _isLoading = false;

  List<dynamic> get results => _results;
  bool get isLoading => _isLoading;

  final TMDBApi _tmdbApi = TMDBApi();

  Future<void> search(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      final movieResults = await _tmdbApi.searchMovies(query);
      final tvShowResults = await _tmdbApi.searchTVShows(query);

      _results = movieResults + tvShowResults;  // Combine movie and TV show results
    } catch (e) {
      _results = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setMovies(List<dynamic> newMovies) {
    _results = newMovies;
    notifyListeners();
  }
}
