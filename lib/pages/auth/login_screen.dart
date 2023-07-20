import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/avatar.dart';
import 'package:flutter_shop_app/widgets/snackbar_utils.dart';
import 'package:flutter_shop_app/endpoints/auth_endpoints.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/models/authentication.dart';
import 'package:flutter_shop_app/pages/auth/register_screen.dart';
import 'package:flutter_shop_app/pages/nature.dart';
import 'package:logger/logger.dart';

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

  Future<ApiResult<UserWithToken>> loginFuture() async {
    return await AuthEndpoints()
        .loginUser(_emailController.text, _passwordController.text);
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

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      loginFuture().then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.isSuccessful) {
          // todo: cache token
          final results = value.result!;
          debugPrint(results.accessToken);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const Nature();
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
