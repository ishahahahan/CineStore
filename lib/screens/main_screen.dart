import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../bottom_nav_bar_screens/bookmarks.dart';
import '../bottom_nav_bar_screens/home.dart';
import '../bottom_nav_bar_screens/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookmarksScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'IMDb',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.account_circle, size: 35),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              selectedColor: const Color(0xff4055C6),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
              selectedColor: const Color(0xff4055C6),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.bookmark),
              title: const Text('Bookmarks'),
              selectedColor: const Color(0xff4055C6),
            ),
          ],
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
