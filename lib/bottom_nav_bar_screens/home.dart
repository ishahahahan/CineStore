import 'package:flutter/material.dart';
import '../home_page/movie_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _bodyText = "";
  String _selectedButton = 'Recently Added';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: _selectedButton == 'Recently Added'
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _bodyText = "Recently Added";
                    _selectedButton = 'Recently Added';
                  }),
                  child: Text(
                    'Recently Added',
                    style: _selectedButton == 'Recently Added'
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: _selectedButton == 'Popular'
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _bodyText = "Popular";
                    _selectedButton = 'Popular';
                  }),
                  child: Text(
                    'Popular',
                    style: _selectedButton == 'Popular'
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: _selectedButton == 'Top Rated'
                      ? ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70)
                      : null,
                  onPressed: () => setState(() {
                    _bodyText = "Top Rated";
                    _selectedButton = 'Top Rated';
                  }),
                  child: Text(
                    'Top Rated',
                    style: _selectedButton == 'Top Rated'
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const MovieListPage(),
        ],
      ),
    );
  }
}
