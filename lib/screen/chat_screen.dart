import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: StreamBuilder(
          /// Before using Firestore,
          /// you must first have ensured you have initialized FlutterFire.
          ///
          /// To create a new Firestore instance,
          /// call the instance getter on FirebaseFirestore:
          ///
          /// By default, listeners do not update
          /// if there is a change that only affects the metadata.
          /// If you want to receive events when the document or
          /// query metadata changes,
          /// you can pass includeMetadataChanges:true to the snapshots method:
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
            final documents = streamsnapshot.data?.docs;
            return ListView.builder(
              itemCount: documents?.length,
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(8),
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
        ));
  }
}
