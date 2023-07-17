import 'package:flutter/material.dart';
import 'package:flutter_shop_app/themes/dark_theme.dart';
import 'package:flutter_shop_app/themes/light_theme.dart';
import 'pages/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'My Shop App',
      home: const LoginScreen(),
    );
  }
}
