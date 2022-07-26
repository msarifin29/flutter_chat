import 'package:cloud_firestore/cloud_firestore.dart';
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
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createAt': Timestamp.now(),
      },
    );
    // delete the text that has been sent
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s10),
      child: Container(
        margin: const EdgeInsets.only(top: Sizes.s5),
        padding: const EdgeInsets.all(Sizes.s5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.s10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  label: Text('Send a message'),
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
            IconButton(
              onPressed: _enteredMessage.isEmpty ? null : () => _sendMessages(),
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
