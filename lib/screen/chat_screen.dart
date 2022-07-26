import 'package:chat/constants/app_colors.dart';
import 'package:chat/constants/app_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Icons.logout,
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
            icon: const Icon(Icons.more_vert),
          ),
          w10,
        ],
      ),
      body: StreamBuilder(
        ///Read data
        ///
        ///By default, listeners do not update
        ///if there is a change that only affects the metadata.
        ///If you want to receive events
        ///when the document or query metadata changes,
        ///you can pass (includeMetadataChanges : true) to the snapshots method.
        stream: FirebaseFirestore.instance
            .collection('chats/CUijsI0WySiKnNJ4cahW/messages')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // To acces the document with QuerySnapshot
          final documents = streamsnapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(Sizes.s5),
              child: Text(documents![i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.message,
        ),
      ),
    );
  }
}
