import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imdb/auth/welcome.dart';
import 'package:imdb/bottom_nav_bar_screens/bookmarks.dart'; // Import the Bookmarks screen
import '../main.dart';
import '../screens/watched_screen.dart'; // Import the Watched Movies screen

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, Key? customKey});

  static const String id = '/profile';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCurrentUser(), // Call fetchCurrentUser asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching user data
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Show an error message if fetching user data fails
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            ),
          );
        } else {
          // Extract user data from the snapshot
          final currentUser = snapshot.data?[0];
          final username = currentUser?['first_name'] ?? 'Unknown';
          final email = currentUser?['email'] ?? 'Unknown';

          return FutureBuilder<int>(
            future: countMoviesWatched(currentUser),
            builder: (context, countSnapshot) {
              if (countSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final moviesWatchedCount = countSnapshot.data ?? 0;

                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Profile'),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle,
                            size: 100.0, color: Colors.grey[700]),
                        // Basic information
                        Text(
                          '$username',
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '$email',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 16.0),
                        // Number of movies watched
                        Text(
                          'Movies Watched: $moviesWatchedCount',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 16.0),
                        // Navigation buttons
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Bookmarks page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookmarksScreen()),
                            );
                          },
                          child: const Text('Bookmarks'),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Watched Movies page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WatchedMoviesScreen()));
                          },
                          child: const Text('Watched Movies'),
                        ),
                        const SizedBox(height: 8.0),
                        // Logout button
                        ElevatedButton(
                          onPressed: () {
                            // Perform logout action
                            supabase.auth.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              WelcomeScreen.id,
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchCurrentUser() async {
    final response = supabase.auth.currentUser!.id;
    final res = await supabase.from('viewers').select().eq('user_id', response);
    return res;
  }

  Future<int> countMoviesWatched(Map<String, dynamic>? userData) async {
    if (userData == null) return 0;
    final userId = userData['user_id'];
    final response =
        await supabase.from('watched').select('movieid').eq('user_id', userId);

    final count = response.length;
    return count;
  }
}
