import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailScreen extends StatelessWidget {
  String? movietitle;
  String? movieimg;
  String? movieoverview;

  MovieDetailScreen(
      {required this.movieimg,
      required this.movieoverview,
      required this.movietitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movietitle ?? 'Movie Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movieimg != null
                ? CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movieimg}',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : const Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movietitle ?? 'No Title',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movieoverview ?? 'No Description',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
