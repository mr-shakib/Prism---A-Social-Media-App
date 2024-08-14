import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prism/firebase_options.dart';
import 'package:prism/services/auth/auth_gate.dart';
import 'package:prism/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'services/database/database_provider.dart';

void main() async {
  // Firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize ThemeProvider before running the app
  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeFromPrefs();

  // Run app
  runApp(
    MultiProvider(
      providers: [
        // Theme provider
        ChangeNotifierProvider.value(
          value: themeProvider,
        ),

        // Database provider
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthGate(),
      },
      theme: themeProvider.themeData,
    );
  }
}
