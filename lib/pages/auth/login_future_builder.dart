import 'package:flutter/material.dart';
import 'package:flutter_shop_app/endpoints/auth_endpoints.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/pages/nature.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final logger = Logger();

  Future<ApiResult>? loginFuture;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 164, 220, 247),
                    child: Icon(
                      Icons.person,
                      size: 55,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: "Enter email address",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: "Enter password",
                  prefixIcon: Icon(
                    Icons.lock_person,
                    color: Colors.blue,
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, 50),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loginFuture = AuthEndpoints().loginUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                    });
                  }
                },
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              if (loginFuture != null) fetchFromApi(loginFuture),
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

  FutureBuilder<ApiResult> fetchFromApi(Future<ApiResult>? loginFuture) {
    return FutureBuilder<ApiResult>(
      future: loginFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          if (snapshot.data!.isSuccessful) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const Nature();
              }),
              (route) => false,
            );
          } else {
            return Text("Error: ${snapshot.data!.message}");
          }
        }
        return const SizedBox.shrink(); // add a return statement at the end
      },
    );
  }
}

enum Gender {
  male,
  female,
  other,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    var formKey;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ...
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                items: Gender.values.map((gender) {
                  return DropdownMenuItem<Gender>(
                    value: gender,
                    child: Text(gender.toString().split('.').last),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Gender",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select your gender";
                  }
                  return null;
                },
              ),
              // ...
            ],
          ),
        ),
      ),
    );
  }
}
