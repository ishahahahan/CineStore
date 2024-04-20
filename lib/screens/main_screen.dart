import 'package:flutter/material.dart';
import 'package:imdb/auth/welcome.dart';
import 'package:imdb/main.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../bottom_nav_bar_screens/bookmarks.dart';
import '../bottom_nav_bar_screens/home.dart';
import '../bottom_nav_bar_screens/search.dart';
import '../bottom_nav_bar_screens/community_chat.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
    const ChatScreen(),
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () async {
                  // Sign Out
                  await supabase.auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.id, (route) => false);
                },
                icon: const Icon(Icons.account_circle, size: 35),
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
              title: const Text('Watchlist'),
              selectedColor: const Color(0xff4055C6),
            ),
            SalomonBottomBarItem(
                icon: const Icon(Icons.chat),
                title: const Text('Chat'),
                selectedColor: const Color(0xff4055C6)),
          ],
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
