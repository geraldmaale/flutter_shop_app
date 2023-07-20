import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/avatar.dart';
import 'package:flutter_shop_app/widgets/snackbar_utils.dart';
import 'package:flutter_shop_app/services/auth_service.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/pages/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // properties for fields
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _snackBarUtils = const SnackBarUtils();

  bool isLoading = false;

  Future<ApiResult> registerFuture() async {
    return await AuthService().createUser(
      _emailController.text,
      _fullNameController.text,
      _passwordController.text,
      _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Account'),
      ),
      body: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Avatar(),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter username' : null,
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
                    validator: (value) =>
                        value!.isEmpty ? 'Enter full name' : null,
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: "Enter full name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter password' : null,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: "Enter password",
                      prefixIcon: Icon(
                        Icons.lock_person,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Confirm password' : null,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: "Enter password",
                      prefixIcon: Icon(
                        Icons.lock_person,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: isLoading ? null : _onRegister,
                    child: Center(
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Register",
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
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      registerFuture().then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.isSuccessful) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const LoginScreen();
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
