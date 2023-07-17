import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // properties for fields
  static late String _email;
  static late String _password;
  static late String _confirmPassword;
  static late String _fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
                onChanged: (value) => _email = value,
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
                validator: (value) => value!.isEmpty ? 'Enter full name' : null,
                onChanged: (value) => _fullName = value,
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
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
                onChanged: (value) => _password = value,
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
                onChanged: (value) => _confirmPassword = value,
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    //todo: register user
                    print("Email: $_email");
                    print("Full Name: $_fullName");
                    print("Password: $_password");
                    print("Confirm Password: $_confirmPassword");
                  } else {
                    // Do something
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: const Center(
                    child: Text(
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
    );
  }
}
