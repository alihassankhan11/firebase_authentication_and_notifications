// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/common_pages/second_page.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class MainPageForGoogleSignin extends StatefulWidget {
  const MainPageForGoogleSignin({Key? key}) : super(key: key);

  @override
  _MainPageForGoogleSigninState createState() =>
      _MainPageForGoogleSigninState();
}

class _MainPageForGoogleSigninState extends State<MainPageForGoogleSignin> {
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
                await signInWithGoogle();

                showSnackBar('Sign in successfull');
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
              },
              child: Text('Login with google'),
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
