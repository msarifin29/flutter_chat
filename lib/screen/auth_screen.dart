import 'package:chat/screen/chat_screen.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      bool isLogin, BuildContext ctx) async {
    try {
      setState(
        () {
          isLoading = true;
        },
      );
      if (isLogin) {
        // Users sign-in with email and password
        await credential.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        // Create a new user account with email and password
        final userCredential = await credential.createUserWithEmailAndPassword(
            email: email, password: password);
        // Storing extra data user
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {'username': userName, 'email': email},
        );
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occured, please check your credential';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        // Get a user's profile information
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return const ChatScreen();
          }
          return AuthForm(
            submitFn: _submitAuthForm,
            isLoading: isLoading,
          );
        },
      ),
    );
  }
}
