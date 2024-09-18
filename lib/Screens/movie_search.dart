import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_repo.dart';
import '../widgets/gridwidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieProvider.fetchMovies();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        movieProvider.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Movies',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                if (query.length > 2) {
                  movieProvider.updateQuery(query);
                }
              },
            ),
          ),
          Expanded(
            child: /*movieProvider.movieModel.results == 0
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : movieProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(movieProvider.errorMessage))
                    : */
                GridView.builder(
              padding: EdgeInsets.all(16),
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: movieProvider.movieModel.results?.length,
              itemBuilder: (context, index) {
                if (index == movieProvider.movieModel.results) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MovieGridItem(
                  movietitle: movieProvider.movieModel.results?[index].title,
                  movieimg: movieProvider.movieModel.results?[index].posterPath,
                  movieoverview:
                      movieProvider.movieModel.results?[index].overview,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
