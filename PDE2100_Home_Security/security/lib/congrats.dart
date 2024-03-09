//The code below provides text input fields for email and password, as well as a button to sign in
//with those credentials. The _signInWithEmailAndPassword method uses Firebase Authentication
//to complete the sign-in procedure. If authentication is successful, it will proceed to
//the '/first' route. If there is an authentication error, it will show an alert dialogue with an error message.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CongratsPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If authentication succeeds, navigate to the next screen
      Navigator.pushReplacementNamed(context, '/first');
    } on FirebaseAuthException catch (e) {
      print('Error is:');
      print(e);
      //if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      // Handle invalid user credentials
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
