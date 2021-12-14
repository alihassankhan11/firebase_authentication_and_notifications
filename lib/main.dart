// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'common_pages/error_page.dart';
import 'common_pages/loading_page.dart';
import 'notifications/notification_cloud_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Widget getPageOf = LoadingPage();
  User? user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        } else if (snapshot.connectionState == ConnectionState.done) {
          FirebaseMessaging.instance.subscribeToTopic('hassan');
          //________________this portion is used for authentications portion you can use this by uncommint this

          // User? user = FirebaseAuth.instance.currentUser;
          // if (user == null) {
          //   return MainPagePhoneAuth();
          // } else {
          //   return SecondPage();
          // }

          //________________this portion
          return NotificationPage();
        } else {
          return LoadingPage();
        }
      },
    );
  }
}



//=====================================================================================
//                              Firebase in app messaging
//=====================================================================================
// ignore_for_file: require_trailing_commas
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:async';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   static FirebaseAnalytics analytics = FirebaseAnalytics();
//   static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();

//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('In-App Messaging example'),
//       ),
//       body: Builder(builder: (BuildContext context) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               AnalyticsEventExample(),
//               ProgrammaticTriggersExample(fiam),
//             ],
//           ),
//         );
//       }),
//     ));
//   }
// }

// class ProgrammaticTriggersExample extends StatelessWidget {
//   const ProgrammaticTriggersExample(this.fiam);

//   final FirebaseInAppMessaging fiam;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: <Widget>[
//             const Text(
//               'Programmatic Trigger',
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text('Manually trigger events programmatically '),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 fiam.triggerEvent('chicken_event');
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   content: Text('Triggering event: chicken_event'),
//                 ));
//               },
//               style: ElevatedButton.styleFrom(primary: Colors.blue),
//               child: Text(
//                 'Programmatic Triggers'.toUpperCase(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnalyticsEventExample extends StatelessWidget {
//   Future<void> _sendAnalyticsEvent() async {
//     await MyApp.analytics
//         .logEvent(name: 'awesome_event', parameters: <String, dynamic>{
//       'int': 42, // not required?
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: <Widget>[
//             const Text(
//               'Log an analytics event',
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text('Trigger an analytics event'),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 _sendAnalyticsEvent();
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   content: Text('Firing analytics event: awesome_event'),
//                 ));
//               },
//               style: ElevatedButton.styleFrom(primary: Colors.blue),
//               child: Text(
//                 'Log event'.toUpperCase(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
