import 'package:chat_app/services/auth/auth_gate.dart';

import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppPreference.initHive();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (BuildContext, themeProvider, child) {
      return GetMaterialApp(
        theme: themeProvider.themeData,
      debugShowCheckedModeBanner: false,
      //darkTheme: Provider.of<ThemeProvider>(context).themeData,
      
      home: AuthGate(),
    );
    });
  }
}
