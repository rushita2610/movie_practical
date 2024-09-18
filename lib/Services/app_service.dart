import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/moviemodel.dart';

class MovieService {
  final String apiKey = 'db581364b8d99226cd4bc0bea7d0fb7d';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjU4MTM2NGI4ZDk5MjI2Y2Q0YmMwYmVhN2QwZmI3ZCIsIm5iZiI6MTcyNjU4NzMwNS44MzgyNTUsInN1YiI6IjY2ZTk3N2I2ODJmZjg3M2Y3ZDFlYjZlYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Gc6NmqEHNl01vpgrc7fOEjuoCo8_gCBXamQilsbDQC8';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<dynamic> fetchMovies(String query, int page) async {
    final url = Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page');

    print("Search Api url = $url");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $readAccessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        print("Response Status Code = ${response.statusCode}");
        print("Response body = ${response.body}");
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        print("Error Status Code = ${response.statusCode}");
        print("Error body = ${response.body}");
        throw Exception('Failed to load movies');
      }
    } on TimeoutException {
      throw Exception('The connection has timed out, please try again later.');
    } catch (e) {
      print("Exception in fetch popular movie = $e");
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> fetchPopularMovies(int page) async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page');

    print("Search Api url = $url");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $readAccessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        print("Response Status Code = ${response.statusCode}");
        print("Response body = ${response.body}");
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        print("Error Status Code = ${response.statusCode}");
        print("Error body = ${response.body}");
        throw Exception('Failed to load popular movies');
      }
    } on TimeoutException {
      throw Exception('The connection has timed out, please try again later.');
    } catch (e) {
      print("Exception in fetch popular movie = $e");
      throw Exception('Error: $e');
    }
  }
}
