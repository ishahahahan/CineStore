import 'package:flutter/material.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String id = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String firstName = '';
  String lastName = '';
  int age = 0;
  String password = '';
  String confirmPassword = '';
  String email = '';

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
              decoration: const InputDecoration(
                hintText: 'First Name',
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                firstName = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Last Name',
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => lastName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Age',
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => age = int.parse(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => email = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => password = value,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => confirmPassword = value,
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
              onPressed: () {
                bool notEmpty = firstName.isNotEmpty &&
                    lastName.isNotEmpty &&
                    age != 0 &&
                    email.isNotEmpty &&
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty;

                if (password == confirmPassword && notEmpty) {
                  print('First Name: $firstName');
                  print('Last Name: $lastName');
                  print('Age: $age');
                  print('Email: $email');
                  print('Password: $password');
                  Navigator.pushNamed(context, HomeScreen.id);
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
