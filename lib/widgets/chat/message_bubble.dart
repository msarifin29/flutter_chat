// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:chat/constants/app_colors.dart';

import '../../constants/app_size.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.keyValue,
    required this.userName,
  }) : super(key: key);

  final String message;
  final bool isMe;
  final Key keyValue;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: Sizes.s200,
          margin: const EdgeInsets.all(Sizes.s8),
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s16, vertical: Sizes.s5),
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.only(
              topLeft: !isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(Sizes.s16),
              topRight: isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(Sizes.s16),
              bottomLeft: const Radius.circular(Sizes.s16),
              bottomRight: const Radius.circular(Sizes.s16),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: isMe ? whiteColor : blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
