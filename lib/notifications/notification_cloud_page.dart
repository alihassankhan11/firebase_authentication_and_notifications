import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

Future<void> adflasdf() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

class _NotificationPageState extends State<NotificationPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String messageText;

  @override
  void initState() {
    super.initState();

    messageText = 'yaha message ana ha';
//___________________________________Forground message
    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) {
    //     // messaging.getToken;

    //     print('Got a message whilst in the foreground!');
    //     print('Message data: ${message.data}');
    //     RemoteNotification notification = message.notification!;
    //     AndroidNotification android = message.notification!.android!;
    //     if (message.notification != null) {
    //       setState(() {
    //         messageText = message.notification!.body!;
    //       });

    //       print(
    //           'Message also contained a notification: ${message.notification?.title}');
    //     }
    //   },
    // );
  }

//___________________________________Background message
  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    if (message.notification != null) {
      // setState(() {
      //   messageText = message.notification!.body!;
      // });

      print(
          'Message also contained a notification: ${message.notification?.title}');
    }
    // print("Handling a background message: ${message.notification?.title}");
  }

  void sdfajs() {
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
  }

//_____________________________________Background message with tap interection means jab user notification par tap kary ga to notification ma data ly kar hum koi function perform karwa sakty ha
  // void _handleMessage(RemoteMessage message) {
  //   if (message.data['type'] == 'chat') {
  //     // Navigator.pushNamed(
  //     //   context,
  //     //   '/chat',
  //     //   arguments: ChatArguments(message),
  //     // );

  //     setState(() {
  //       messageText = message.notification!.body!;
  //     });
  //   }
  // }

  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }

  @override
  Widget build(BuildContext context) {
    // setupInteractedMessage();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'hello hi how are you',
            ),
            Text(
              messageText,
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  callOnFcmApiSendPushNotifications();
                },
                child: const Text('Send Message')),
          ],
        ),
      ),
    );
  }

  void callOnFcmApiSendPushNotifications() async {
    var idToken =
        'AAAAT1C1Lls:APA91bEwOSOcuNUHpuSdOoshH-ekiw8CtoRJ6_J_vXhCYOh-TVh7ylSN8JWctgnZnP_GZLxmeeUVKhd1lZk744l3clJvoDhadvrjvKXYK6Vh9hBPPDYKpLZ4QUmIBUeDRsgzWZcksoqn';

    print(
        ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$idToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is body',
            'title': 'title',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': '/topics/hassan',
        },
      ),
    );

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
    } else {
      print(' CFM error');
      // on failure do sth

    }
  }
}
