import 'package:flutter/material.dart';
import 'package:flutter_shop_app/endpoints/auth_endpoints.dart';
import 'package:flutter_shop_app/pages/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // properties for fields
  late String email;
  late String password;
  late String confirmPassword;
  late String fullName;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  validator: (value) =>
                      value!.isEmpty ? 'Enter full name' : null,
                  onChanged: (value) => fullName = value,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: "Enter full name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter password' : null,
                  onChanged: (value) => password = value,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: "Enter password",
                    prefixIcon: Icon(
                      Icons.lock_person,
                      color: Colors.blue,
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
                  onChanged: (value) => confirmPassword = value,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: "Enter password",
                    prefixIcon: Icon(
                      Icons.lock_person,
                      color: Colors.blue,
                    ),
                  ),
                  obscureText: true,
                  obscuringCharacter: '*',
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // show loading indicator
                      setState(() {
                        isLoading = true;
                      });

                      var result = await AuthEndpoints().createUser(
                          email, fullName, password, confirmPassword);

                      // hide loading indicator
                      setState(() {
                        isLoading = false;
                      });

                      if (result.isSuccessful) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
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
                          backgroundColor:
                              const Color.fromARGB(255, 167, 15, 4),
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
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
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
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
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
    );
  }
}
