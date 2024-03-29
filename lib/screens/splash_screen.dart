import 'package:flutter/material.dart';
import 'package:imdb/auth/welcome.dart';
import 'package:imdb/main.dart';
import 'package:imdb/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);

    if (!mounted) return;

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
