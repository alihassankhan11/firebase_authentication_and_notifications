// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/auth_pages/main_page_anonymous.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Second Page',
              style: TextStyle(
                  // color: Colors.red,
                  ),
            ),
            ElevatedButton(
              onPressed: () async {
                await firebaseAuth.signOut();
                firebaseAuth.authStateChanges().listen(
                  (User? user) {
                    if (user == null) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (buildContext) {
                          return MainPageForAnonymousLogin();
                        },
                      ), (route) => false);
                    } else {
                      showSnackBar('There is an error');
                    }
                  },
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
