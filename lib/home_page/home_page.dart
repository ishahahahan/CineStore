import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? title;
  const HomePage({super.key, this.title});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(20, 15),
                      topRight: Radius.elliptical(20, 15),
                      bottomLeft: Radius.elliptical(20, 15),
                      bottomRight: Radius.elliptical(20, 15),
                    ),
                    child: Image.network(
                      'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p7825626_p_v8_af.jpg',
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire area
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
          );
        },
      ),
    );
  }
}
