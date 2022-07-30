import 'package:chat/constants/app_colors.dart';
import 'package:chat/constants/app_size.dart';
import 'package:chat/widgets/chat/messages.dart';
import 'package:chat/widgets/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fm = FirebaseMessaging.instance;
    // Android applications are not required to request permission.
    fm.requestPermission();

    /// To listen to messages whilst your application is in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      // ignore: avoid_print
      print(message);
      return;
    });

    /// Also handle any interaction when the app is in the background via a
    /// Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // ignore: avoid_print
      print(message);
      return;
    });
    // subscribe to topic on each app start-up
    fm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepColor,
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton<String>(
            items: [
              DropdownMenuItem<String>(
                value: 'logout',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: blackColor,
                    ),
                    Text('logout'),
                  ],
                ),
              ),
            ],
            onChanged: (newValue) {
              if (newValue == 'logout') {
                // Sign out a users
                FirebaseAuth.instance.signOut();
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
          w10,
        ],
      ),
      body: SizedBox(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Expanded(
              child: Messages(),
            ),
            const NewMessages(),
          ],
        ),
      ),
    );
  }
}
