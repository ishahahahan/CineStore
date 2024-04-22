import 'package:flutter/material.dart';
import 'package:imdb/home_page/movie_list_page.dart';
import 'package:imdb/main.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key, Key? customKey});

  @override
  BookmarksScreenState createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<BookmarksScreen> {
  late Future<List<Map<String, dynamic>>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _bookmarksFuture = fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _bookmarksFuture,
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
            child: Text('Add movies to your watchlist'),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Watchlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  MovieListPage(
                    movies: _bookmarksFuture,
                    isBookmark: true,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchBookmarks() async {
    final currentUser = supabase.auth.currentUser;
    print(currentUser?.id);
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await supabase
          .from('watchlist')
          .select('movieid, movies(title, imageurl)')
          .eq('user_id', currentUser.id);

      final List<Map<String, dynamic>> bookmarks = [];

      for (final item in response) {
        final Map<String, dynamic> bookmark = {
          'movieid': item['movieid'],
          'title': item['movies']['title'],
          'imageurl': item['movies']['imageurl'],
        };
        bookmarks.add(bookmark);
      }

      print(bookmarks);

      return bookmarks;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch bookmarks: $e');
    }
  }
}
