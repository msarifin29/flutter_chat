import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      ///Read data
      ///
      ///By default, listeners do not update
      ///if there is a change that only affects the metadata.
      ///If you want to receive events
      ///when the document or query metadata changes,
      ///you can pass (includeMetadataChanges : true) to the snapshots
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // To acces the document with QuerySnapshot
        final chatDocs = streamSnapshot.data?.docs;
        return FutureBuilder(
          future: Future.value(FirebaseAuth.instance.currentUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs!.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: chatDocs[index]['text'],
                  keyValue: ValueKey(chatDocs[index].id),
                  userName: chatDocs[index]['username'],
                  userImage: chatDocs[index]['userImage'],
                  isMe: chatDocs[index]['userId'] == user?.uid,
                );
              },
            );
          },
        );
      },
    );
  }
}
