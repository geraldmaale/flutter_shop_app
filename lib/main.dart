import 'package:flutter/material.dart';
import 'package:flutter_shop_app/pages/auth/register_screen.dart';
import 'package:flutter_shop_app/pages/nature.dart';
import 'package:flutter_shop_app/providers/user_provider.dart';
import 'package:flutter_shop_app/services/auth_service.dart';
import 'package:flutter_shop_app/themes/dark_theme.dart';
import 'package:flutter_shop_app/themes/light_theme.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'pages/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

// Register providers
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'My Shop App',
      home: FutureBuilder<String>(
        future: _authService.getUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Logger().i("user token ", snapshot.data);
              return const Nature();
            } else if (snapshot.hasError) {
              // Show loading indicator
              return const LoginScreen();
            } else {
              // Show loading indicator
              return const RegisterScreen();
            }
          } else {
            // Show loading indicator
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
