// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/common_pages/second_page.dart';

import 'package:flutter/material.dart';

class MainPagePhoneAuth extends StatefulWidget {
  const MainPagePhoneAuth({Key? key}) : super(key: key);

  @override
  _MainPagePhoneAuthState createState() => _MainPagePhoneAuthState();
}

class _MainPagePhoneAuthState extends State<MainPagePhoneAuth> {
  String phoneNumber = '';
  String code = '';
  var phoneNumberController = TextEditingController();
  var otpController = TextEditingController();
  String varificationId = '';
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
            TextField(
              controller: phoneNumberController,
            ),
            TextField(
              controller: otpController,
            ),
            ElevatedButton(
              onPressed: () {
                fetchOtp();
              },
              child: Text('Fetch OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                varify();
              },
              child: Text('Send'),
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

  Future<void> fetchOtp() async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text.toString(),
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException firebaseAuthException) {
        if (firebaseAuthException.code == 'invalid-phone-number') {
          showSnackBar('Invalid phone number');
        }
      },
      codeSent: (String varificationId, int? resendToken) async {
        this.varificationId = varificationId;
      },
      codeAutoRetrievalTimeout: (String varificationId) {},
    );
  }

  Future<void> varify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: varificationId,
      smsCode: otpController.text.toString(),
    );
    await _firebaseAuth.signInWithCredential(phoneAuthCredential).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          ),
        );
      },
    );
  }
}
