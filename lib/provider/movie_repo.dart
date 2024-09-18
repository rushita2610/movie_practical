import 'package:flutter/material.dart';

import '../Services/app_service.dart';
import '../model/moviemodel.dart';

class MovieProvider with ChangeNotifier {
  final MovieService movieService = MovieService();
  MovieModel _movieModel = MovieModel();
  bool _isLoading = false;
  bool _hasMore = true;
  String _errorMessage = '';
  String _query = '';

  MovieModel get movieModel => _movieModel;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String get errorMessage => _errorMessage;

  void reset() {
    _movieModel = MovieModel();
    _hasMore = true;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final fetchedModel = _query.isEmpty
          ? await movieService.fetchPopularMovies(1)
          : await movieService.fetchMovies(_query, 1);

      if (fetchedModel.results == null || fetchedModel.results!.isEmpty) {
        _hasMore = false;
      } else {
        if (_query.isEmpty) {
          _movieModel.results = fetchedModel.results;
        } else {
          _movieModel.results!.addAll(fetchedModel.results!);
        }
        _movieModel.page = fetchedModel.page;
        _movieModel.totalPages = fetchedModel.totalPages;
        _movieModel.totalResults = fetchedModel.totalResults;
      }
    } catch (error) {
      _errorMessage = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateQuery(String query) {
    _query = query;
    reset();
    fetchMovies();
  }

  void loadMore() {
    if (_hasMore && !_isLoading) {
      fetchMovies();
    }
  }
}
