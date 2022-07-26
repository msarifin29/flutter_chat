import 'package:chat/constants/app_colors.dart';
import 'package:chat/screen/auth_screen.dart';
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
      home: const AuthScreen(),
    );
  }
}
