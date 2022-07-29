import 'dart:io';

import 'package:chat/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final credential = FirebaseAuth.instance;
  // ignore: prefer_final_fields
  bool isLoading = false;

  void _submitAuthForm(String email, String userName, String password,
      bool isLogin, File? image, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(
        () {
          isLoading = true;
        },
      );
      if (isLogin) {
        // Users sign-in with email and password
        authResult = await credential.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        // Create a new user account with email and password
        authResult = await credential.createUserWithEmailAndPassword(
            email: email, password: password);

        /// First child reference
        /// points to 'user_image'
        ///
        /// Second Child references can also take paths
        ///  points to 'authResult.user.uid' + .jpg
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.user!.uid} .jpg');

        /// Method automatically infers the MIME type from the File extension
        await ref.putFile(image!);

        // Download file
        final url = await ref.getDownloadURL();

        // Storing extra data user
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'username': userName,
            'email': email,
            'image_url': url,
          },
        );
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, please check your credential';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      if (mounted) {
        setState(
          () {
            isLoading = false;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(
        submitFn: _submitAuthForm,
        isLoading: isLoading,
      ),
    );
  }
}
