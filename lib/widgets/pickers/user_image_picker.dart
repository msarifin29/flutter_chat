import 'dart:io';

import 'package:chat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  // ignore: unused_field, prefer_typing_uninitialized_variables
  File? _pickedImages;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image, it will return XFile
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Convert XFile to File
      final File imagefile = File(image.path);
      setState(
        () {
          _pickedImages = imagefile;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: greyColor,
          backgroundImage:
              _pickedImages != null ? FileImage(_pickedImages!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add image'),
        ),
      ],
    );
  }
}
