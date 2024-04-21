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
    print('ssup');
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
          return MovieListPage(movies: _bookmarksFuture);
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
          .select('*, movies(*)')
          .eq('user_id', currentUser.id);

      return response;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch bookmarks: $e');
    }
  }
}
