import 'package:flutter/material.dart';
import 'package:imdb/home_page/movie_list_page.dart';
import 'package:imdb/main.dart';

class WatchedMoviesScreen extends StatefulWidget {
  const WatchedMoviesScreen({super.key});

  @override
  _WatchedMoviesScreenState createState() => _WatchedMoviesScreenState();
}

class _WatchedMoviesScreenState extends State<WatchedMoviesScreen> {
  late Future<List<Map<String, dynamic>>> _watchedMoviesFuture;

  @override
  void initState() {
    super.initState();
    _watchedMoviesFuture = fetchWatchedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _watchedMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('You haven\'t watched any movies yet'),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Watched Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  MovieListPage(
                    movies: _watchedMoviesFuture,
                    isBookmark: false,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchWatchedMovies() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await supabase
          .from('watched')
          .select('movieid, movies(title, imageurl)')
          .eq('user_id', currentUser.id);

      final List<Map<String, dynamic>> watchedMovies = [];

      for (final item in response) {
        final Map<String, dynamic> watchedMovie = {
          'movieid': item['movieid'],
          'title': item['movies']['title'],
          'imageurl': item['movies']['imageurl'],
        };
        watchedMovies.add(watchedMovie);
      }

      return watchedMovies;
    } catch (e) {
      throw Exception('Failed to fetch watched movies: $e');
    }
  }
}
