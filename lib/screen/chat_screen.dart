import 'package:chat/constants/app_colors.dart';
import 'package:chat/constants/app_size.dart';
import 'package:chat/widgets/chat/messages.dart';
import 'package:chat/widgets/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
