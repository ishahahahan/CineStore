import 'package:flutter/material.dart';
import 'package:imdb/screens/home.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark(),
        home: const WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
        });
  }
}
