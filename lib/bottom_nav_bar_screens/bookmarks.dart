import 'package:flutter/material.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Icon(Icons.bookmark),
      ),
    );
  }
}
