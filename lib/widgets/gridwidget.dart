import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:theone_practical/Screens/movie_detail.dart';

class MovieGridItem extends StatelessWidget {
  String? movietitle;
  String? movieimg;
  String? movieoverview;

  MovieGridItem(
      {required this.movieimg,
      required this.movieoverview,
      required this.movietitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movieoverview: movieoverview,
              movieimg: movieimg,
              movietitle: movietitle,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movietitle ?? 'No Title',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
