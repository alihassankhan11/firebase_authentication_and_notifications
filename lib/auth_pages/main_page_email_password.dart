// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/common_pages/second_page.dart';
import 'package:flutter/material.dart';

class MainPageForEmailPassword extends StatefulWidget {
  const MainPageForEmailPassword({Key? key}) : super(key: key);

  @override
  _MainPageForEmailPasswordState createState() =>
      _MainPageForEmailPasswordState();
}

class _MainPageForEmailPasswordState extends State<MainPageForEmailPassword> {
  String email = '';
  String password = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    print(_firebaseAuth.currentUser?.email.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (email) {
                this.email = email;
              },
              decoration: InputDecoration(hintText: 'Enter mail'),
            ),
            TextField(
              onChanged: (password) {
                this.password = password;
              },
              decoration: InputDecoration(hintText: 'Enter password'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firebaseAuth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
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
                  showSnackBar('Login successfully');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    showSnackBar('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showSnackBar('The account already exists for that email.');
                  }
                } catch (e) {
                  showSnackBar(e.toString());
                }
              },
              child: Text('Login with email password'),
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
