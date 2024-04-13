import 'package:flutter/material.dart';
import 'package:imdb/home_page/movie_list_page.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  BookmarksScreenState createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<BookmarksScreen> {
  final titles = [
    'Interstellar',
    'Inception',
    'The Dark Knight',
    'The Prestige',
    'Memento',
    'Dunkirk',
    'Tenet',
    'Batman Begins',
    'Oppenheimer',
    'The Dark Knight Rises'
  ];

  @override
  Widget build(BuildContext context) {
    return const MovieListPage();
  }
}
