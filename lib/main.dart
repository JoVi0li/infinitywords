import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/firebase_options.dart';
import 'package:infinitywords/shared/inject/inject.dart';
import 'package:infinitywords/shared/themes/button_theme.dart';
import 'package:infinitywords/shared/themes/text_theme.dart';

import 'modules/auth/presenter/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Inject.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121126),
        textTheme: CustomTextTheme()(),
        outlinedButtonTheme: CustomButtonTheme.outlinedButtonThemeData(),
      ),
      home: const SignInScreen(),
    );
  }
}
