import 'package:flutter/material.dart';
import 'package:imdb/home_page/movie_list_page.dart';
import 'package:imdb/main.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  BookmarksScreenState createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return MovieListPage(
      movies: fetchBookmarks(),
    );
  }

  Future<List<Map<String, dynamic>>> fetchBookmarks() async {
    final response =
        await supabase.from('movies').select().order('title', ascending: true);

    return response;
  }
}
