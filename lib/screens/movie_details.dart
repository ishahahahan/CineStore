import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Movie Poster
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Container(
                height: 300, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Movie Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Release Date: September 3, 2023', // Example detail, replace with actual movie details
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
                    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                    'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Crews Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crews',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // TODO: Add crew members here
                  Text(
                    'Director: Christopher Nolan\n'
                    'Writer: Jonathan Nolan',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Movie Rating Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate this movie',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // TODO: Add rating stars here
                  // You can use a package like flutter_rating_bar for rating stars
                  // Example: RatingBar.builder(...)
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add movie to watchlist
          // You can implement the logic here to add the movie to the watchlist
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to watchlist')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



// ChatGPT Generated actual code for the Movie Details Page with Supabase integration
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class MovieDetailsPage extends StatelessWidget {
//   final String movieId;

//   const MovieDetailsPage({
//     Key? key,
//     required this.movieId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie Details'),
//       ),
//       body: StreamBuilder(
//         stream: supabase
//             .from('movies')
//             .select()
//             .eq('id', movieId)
//             .single()
//             .execute(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('Movie not found'));
//           }

//           final movieData = snapshot.data!.toJson();

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Movie Poster
//                 Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.0),
//                     image: DecorationImage(
//                       image: NetworkImage(movieData['imageUrl']),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16.0),

//                 // Movie Details
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         movieData['title'],
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         movieData['description'],
//                         style: TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Text(
//                         'Rating: ${movieData['rating']}',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16.0),

//                 // Crews Section
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Crews',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         'Director: ${movieData['director']}\n'
//                         'Writer: ${movieData['writer']}',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16.0),

//                 // Movie Rating Section
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Rate this movie',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       // TODO: Add rating stars here
//                       // You can use a package like flutter_rating_bar for rating stars
//                       // Example: RatingBar.builder(...)
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add movie to watchlist
//           // You can implement the logic here to add the movie to the watchlist
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Added to watchlist')),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
