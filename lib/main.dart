import 'package:flutter/material.dart';
import 'package:imdb/screens/main_screen.dart';
import 'package:imdb/screens/splash_screen.dart';
import 'auth/welcome.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: kSUPABASE_URL,
    anonKey: kANON_KEY,
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark(),
        home: const WelcomeScreen(),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          MainScreen.id: (context) => const MainScreen(),
        });
  }
}
