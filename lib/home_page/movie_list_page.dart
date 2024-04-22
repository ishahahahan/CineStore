import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/movie_details.dart';

class MovieListPage extends StatefulWidget {
  final int? sortType;
  final bool? isBookmark;
  final Future<List<Map<String, dynamic>>> movies;
  const MovieListPage(
      {super.key,
      this.sortType,
      this.isBookmark = false,
      required this.movies});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  late Future<List<Map<String, dynamic>>> movies = widget.movies;
  bool _isMounted = false;
  int choice = 0;
  Key gridViewKey = UniqueKey(); // Add a key for GridView.builder

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    choice = widget.sortType ?? 0;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MovieListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sortType != widget.sortType) {
      choice = widget.sortType ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.movies, // Use widget.movies as the future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is loading, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Once the future has completed, get the list of movies from the snapshot
          List<Map<String, dynamic>> movies = snapshot.data!;
          // Access the length property of the list
          int itemCount = movies.length;
          return GridView.builder(
            key: gridViewKey,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final movie = movies[index];
              print(movie);
              return GestureDetector(
                onLongPress: () {
                  if (widget.isBookmark == true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Add to watched list?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Update the state to remove the movie from the list
                                setState(() {
                                  movies.removeAt(index);
                                  // add the movie to the watched table
                                  addMovieToWatched(movie['movieid'] as int);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onTap: () {
                  if (_isMounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(
                          movieId: movie['movieid'].toString(),
                        ),
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
                            movie['imageurl'] ??
                                'https://i.pinimg.com/736x/c5/0b/7b/c50b7be4d3a21f765097ca12147ed5f4.jpg',
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
          );
        }
      },
    );
  }
Future<void> addMovieToWatched(int movieId) async {
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) {
    // Handle case where user ID is null (e.g., user not authenticated)
    print('User ID is null. Cannot add movie to watched list.');
    return;
  }
  
  try {
    // Add the movie to the watched table
    await supabase.from('watched').insert({
      'movieid': movieId,
      'user_id': userId, // Ensure user ID is passed to the insert operation
    });
  } catch (e) {
    // Handle any errors that occur during the insert operation
    print('Error adding movie to watched list: $e');
  }
}

}
