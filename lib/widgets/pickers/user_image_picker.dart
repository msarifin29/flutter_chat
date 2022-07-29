// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chat/constants/app_colors.dart';

import '../../constants/app_size.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    Key? key,
    required this.pickImageFn,
  }) : super(key: key);

  final void Function(File pickedImage) pickImageFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  // ignore: unused_field, prefer_typing_uninitialized_variables
  File? _pickedImages;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image, it will return XFile
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: Sizes.s50.toInt(),
      maxWidth: Sizes.s150,
      maxHeight: Sizes.s150,
    );
    if (image != null) {
      // Convert XFile to File
      final File imagefile = File(image.path);
      setState(
        () {
          _pickedImages = imagefile;
        },
      );
      widget.pickImageFn(
        File(imagefile.path),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: Sizes.s40,
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
