import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/movie_details.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  late List<Map<String, dynamic>> movies = [];
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchMovies();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchMovies() async {
    final response =
        await supabase.from('movies').select('movieid, title, imageurl');
    // if (response.error != null) {
    //   // Handle error
    //   return;
    // }
    if (_isMounted) {
      setState(() {
        movies = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              if (_isMounted) {
                // Navigate to movie details page with movie ID
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailsPage(movieId: movie['movieid'].toString()),
                  ),
                );
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(10, 5),
                  bottomRight: Radius.elliptical(10, 5),
                  topRight: Radius.elliptical(10, 5),
                  bottomLeft: Radius.elliptical(10, 5),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(10, 8.5),
                        bottomRight: Radius.elliptical(10, 8.5),
                        topRight: Radius.elliptical(10, 8.5),
                        bottomLeft: Radius.elliptical(10, 8.5),
                      ),
                      child: Image.network(
                        movie['imageurl'] ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    movie['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
