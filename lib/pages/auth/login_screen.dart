import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/loginrequest.dart';
import 'package:flutter_shop_app/providers/user_provider.dart';
import 'package:flutter_shop_app/widgets/avatar.dart';
import 'package:flutter_shop_app/widgets/bottom_navigation.dart';
import 'package:flutter_shop_app/widgets/snackbar_utils.dart';
import 'package:flutter_shop_app/services/auth_service.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/pages/auth/register_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // properties
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _snackBarUtils = const SnackBarUtils();

  final logger = Logger();
  bool isLoading = false;

  Future<ApiResult> loginFuture(BuildContext context) async {
    final res = await AuthService().loginUser(
      context,
      LoginRequest(
        userName: _emailController.text,
        password: _passwordController.text,
      ),
    );
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Avatar(),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: "Enter username",
                  prefixIcon: Icon(
                    Icons.person_2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "Enter password",
                  prefixIcon: Icon(
                    Icons.lock_person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: isLoading ? null : _onLogin,
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const RegisterScreen();
                        }),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<ApiResult> loginBuilder(BuildContext context) {
    return FutureBuilder<ApiResult>(
      future: AuthService().loginUser(
        context,
        LoginRequest(
          userName: _emailController.text,
          password: _passwordController.text,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          setState(() {
            isLoading = false;
          });

          if (snapshot.hasData) {
            if (snapshot.data!.isSuccessful) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const BottomNavigation();
                }),
                (route) => false,
              );
              return const SizedBox.shrink();
            } else {
              _snackBarUtils.showSnackBarError(context, snapshot.data!.message);
              return const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            logger.e(snapshot.error.toString());
            _snackBarUtils.showSnackBarError(
                context, snapshot.error.toString());
            return const SizedBox.shrink();
          } else {
            logger.i("No user found, redirecting to login screen");
            _snackBarUtils.showSnackBarError(
                context, "No user found, redirecting to login screen");
            return const SizedBox.shrink();
          }
        } else {
          // Show loading indicator
          setState(() {
            isLoading = true;
          });
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      AuthService()
          .loginUser(
        context,
        LoginRequest(
          userName: _emailController.text,
          password: _passwordController.text,
        ),
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.isSuccessful) {
          Provider.of<UserProvider>(context, listen: false)
              .setUserWithToken(value.result!);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const BottomNavigation();
            }),
            (route) => false,
          );
        } else {
          _snackBarUtils.showSnackBarError(context, value.message);
        }
      });
    }
  }
}
