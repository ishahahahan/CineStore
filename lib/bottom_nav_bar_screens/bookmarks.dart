import 'package:flutter/material.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  BookmarksScreenState createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Icon(Icons.bookmark),
      ),
    );
  }
}
