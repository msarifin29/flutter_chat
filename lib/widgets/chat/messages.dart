import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      ///Read data
      ///
      ///By default, listeners do not update
      ///if there is a change that only affects the metadata.
      ///If you want to receive events
      ///when the document or query metadata changes,
      ///you can pass (includeMetadataChanges : true) to the snapshots
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // To acces the document with QuerySnapshot
        final chatDocs = snapshot.data?.docs;
        return ListView.builder(
          itemCount: chatDocs!.length,
          itemBuilder: (context, index) {
            return Text(
              chatDocs[index]['text'],
            );
          },
        );
      },
    );
  }
}
