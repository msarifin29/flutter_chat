import 'package:chat/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/app_size.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  // ignore: unused_field
  var _enteredMessage = '';
  final textController = TextEditingController();

  void _sendMessages() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createAt': Timestamp.now(),
        'userId': user?.uid
      },
    );
    // delete the text that has been sent
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(Sizes.s8),
            elevation: Sizes.s5,
            shadowColor: greyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s20),
            ),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                label: Text('Send a message'),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.s20),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(
                  () {
                    _enteredMessage = value;
                  },
                );
              },
            ),
          ),
        ),
        Card(
          elevation: Sizes.s5,
          shadowColor: greyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s50),
          ),
          child: IconButton(
            onPressed: _enteredMessage.isEmpty ? null : () => _sendMessages(),
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
