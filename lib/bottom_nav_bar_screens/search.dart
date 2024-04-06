import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      child: Icon(Icons.search),
    ));
  }
}
