// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../home_page/movie_list_page.dart';
import '../main.dart';

enum MovieType {
  RecentlyReleased(0),
  Popular(1),
  TopRated(2);

  const MovieType(this.value);
  final int value;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  MovieType _selectedMovieType = MovieType.RecentlyReleased;
  late int _sortType = _selectedMovieType.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: _selectedMovieType == MovieType.RecentlyReleased
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _selectedMovieType = MovieType.RecentlyReleased;
                    _sortType = _selectedMovieType.value;
                    fetchRecentlyReleasedMovies();
                  }),
                  child: Text(
                    'Recently Released',
                    style: _selectedMovieType == MovieType.RecentlyReleased
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: _selectedMovieType == MovieType.Popular
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _selectedMovieType = MovieType.Popular;
                    _sortType = _selectedMovieType.value;
                    fetchPopularMovies();
                  }),
                  child: Text(
                    'Popular',
                    style: _selectedMovieType == MovieType.Popular
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: _selectedMovieType == MovieType.TopRated
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _selectedMovieType = MovieType.TopRated;
                    _sortType = _selectedMovieType.value;
                    fetchTopRatedMovies();
                  }),
                  child: Text(
                    'Top Rated',
                    style: _selectedMovieType == MovieType.TopRated
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MovieListPage(
            movies: _sortType == 0
                ? fetchRecentlyReleasedMovies()
                : _sortType == 1
                    ? fetchPopularMovies()
                    : fetchTopRatedMovies(),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchRecentlyReleasedMovies() async {
    final response = await supabase
        .from('movies')
        .select('movieid, title, imageurl')
        .order('releasedate', ascending: false)
        .limit(10);

    return response;
  }

  Future<List<Map<String, dynamic>>> fetchPopularMovies() async {
    final response = await supabase
        .from('movies')
        .select('movieid, title, imageurl')
        .limit(10);

    return response;
  }

  Future<List<Map<String, dynamic>>> fetchTopRatedMovies() async {
    final response = await supabase
        .from('movies')
        .select('movieid, title, imageurl')
        .order('rating', ascending: false)
        .limit(10);
    return response;
  }
}
