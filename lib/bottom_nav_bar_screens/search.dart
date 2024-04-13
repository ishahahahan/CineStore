import 'package:flutter/material.dart';
import 'package:imdb/home_page/movie_list_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search for movies',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: _searchText.isEmpty
            ? const Center(
                child: Text(
                  'Enter a search query...',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : const MovieListPage(),
      ),
    );
  }
}
