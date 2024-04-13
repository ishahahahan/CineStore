import 'package:flutter/material.dart';
import '../screens/movie_details.dart';

class MovieListPage extends StatefulWidget {
  // final String? title;
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final titles = [
    'Interstellar',
    'Inception',
    'The Dark Knight',
    'The Prestige',
    'Memento',
    'Dunkirk',
    'Tenet',
    'Batman Begins',
    'Oppenheimer',
    'The Dark Knight Rises'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to movie details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                      title: titles[index],
                      imageUrl:
                          'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p7825626_p_v8_af.jpg'),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(10, 5),
                  bottomRight: Radius.elliptical(10, 5),
                  topRight: Radius.elliptical(10, 5),
                  bottomLeft: Radius.elliptical(10, 5),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(10, 8.5),
                        bottomRight: Radius.elliptical(10, 8.5),
                        topRight: Radius.elliptical(10, 8.5),
                        bottomLeft: Radius.elliptical(10, 8.5),
                      ),
                      child: Image.network(
                        'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p7825626_p_v8_af.jpg',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    titles[index],
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
