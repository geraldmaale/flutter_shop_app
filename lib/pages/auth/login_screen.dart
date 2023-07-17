import 'package:flutter/material.dart';
import 'package:flutter_shop_app/endpoints/auth_endpoints.dart';
import 'package:flutter_shop_app/pages/auth/register_screen.dart';
import 'package:flutter_shop_app/pages/nature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // properties
  late String email;
  late String password;
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
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
                onChanged: (value) => email = value,
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
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
                onChanged: (value) => password = value,
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
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // enable loading state
                    setState(() {
                      isLoading = true;
                    });
                    var result =
                        await AuthEndpoints().loginUser(email, password);

                    // disable loading state
                    setState(() {
                      isLoading = false;
                    });

                    if (result.isSuccessful) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const Nature();
                        }),
                        (route) => false,
                      );
                    } else {
                      // show error message
                      final SnackBar snackBar = SnackBar(
                        content: Text(result.message),
                        action: SnackBarAction(
                          label: 'Ok',
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                        backgroundColor: const Color.fromARGB(255, 167, 15, 4),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
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
}
