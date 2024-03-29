import 'package:flutter/material.dart';
import 'package:imdb/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String id = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMDb',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          const Center(
            child: Text('SIGN UP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: 'Age',
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 5),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff4055C6)),
                fixedSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              onPressed: () async {
                final firstName = _firstNameController.text.trim();
                final lastName = _lastNameController.text.trim();
                final age = _ageController.text.trim();
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();
                final confirmPassword = _confirmPasswordController.text.trim();

                if (firstName.isEmpty ||
                    lastName.isEmpty ||
                    age.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty ||
                    confirmPassword.isEmpty) {
                  return;
                }

                if (password != confirmPassword) {
                  return;
                }

                try {
                  final response = await supabase.auth.signUp(
                    password: password,
                    email: email,
                    data: {
                      'first_name': firstName,
                      'last_name': lastName,
                      'age': age,
                    },
                  );

                  if (response.user == null) {
                    return;
                  } else {
                    Navigator.pushReplacementNamed(context, MainScreen.id);
                  }
                } on AuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                    ),
                  );
                } catch (e) {
                  // Handle other exceptions
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('An error occurred'),
                    ),
                  );
                }
              },
              child:
                  const Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
