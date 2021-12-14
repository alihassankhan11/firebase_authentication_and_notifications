// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/common_pages/second_page.dart';

import 'package:flutter/material.dart';

class MainPageForAnonymousLogin extends StatefulWidget {
  const MainPageForAnonymousLogin({Key? key}) : super(key: key);

  @override
  _MainPageForAnonymousLoginState createState() =>
      _MainPageForAnonymousLoginState();
}

class _MainPageForAnonymousLoginState extends State<MainPageForAnonymousLogin> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firebaseAuth.signInAnonymously();
                  showSnackBar('sign in ');
                  print('sign in...........................................');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (buildContext) {
                        return SecondPage();
                      },
                    ),
                    (_) {
                      return false;
                    },
                  );
                } on FirebaseAuthException catch (e) {
                  showSnackBar(e.message ?? e.code);
                }
              },
              child: Text('Login Anonymous'),
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
