import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/firebase_options.dart';
import 'package:infinitywords/modules/home/presenter/screens/home_screen.dart';
import 'package:infinitywords/shared/inject/inject.dart';
import 'package:infinitywords/shared/routes/auth_routes.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';
import 'package:infinitywords/shared/themes/button_theme.dart';
import 'package:infinitywords/shared/themes/input_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121126),
        textTheme: CustomTextTheme()(),
        outlinedButtonTheme: CustomButtonTheme.outlinedButtonThemeData(),
        inputDecorationTheme: CustomInputTheme()(),
      ),
      routes: {
        AuthRoutes.signIn: (context) => const SignInScreen(),
        HomeRoutes.home: (context) => const HomeScreen(),
      },
      initialRoute: AuthRoutes.signIn,
    );
  }
}
