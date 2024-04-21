import 'package:flutter/material.dart';
import 'package:imdb/bottom_nav_bar_screens/bookmarks.dart'; // Import the Bookmarks screen
import '../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String id = '/profile';

  @override
  Widget build(BuildContext context) {
    final currentUser = supabase.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 100.0, color: Colors.grey[700]),
            // Basic information
            Text(
              'Username: ${currentUser?.email ?? 'Unknown'}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: ${currentUser?.email ?? 'Unknown'}',
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
                      builder: (context) => const BookmarksScreen()),
                );
              },
              child: const Text('Bookmarks'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Watched Movies page
              },
              child: const Text('Watched Movies'),
            ),
          ],
        ),
      ),
    );
  }
}
