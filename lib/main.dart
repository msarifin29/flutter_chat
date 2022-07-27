import 'package:chat/constants/app_colors.dart';
import 'package:chat/screen/auth_screen.dart';
import 'package:chat/screen/chat_screen.dart';
import 'package:chat/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'constants/app_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: Colors.grey,
            ),
            backgroundColor: greenColor,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: greenColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Sizes.s20,
                ),
              ),
            ),
          ),
          home: snapshot.connectionState != ConnectionState.done
              ? const SplashScreen()
              : StreamBuilder(
                  // Get a user's profile information
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SplashScreen();
                    }
                    if (userSnapshot.hasData) {
                      return const ChatScreen();
                    }
                    return const AuthScreen();
                  },
                ),
        );
      },
    );
  }
}
