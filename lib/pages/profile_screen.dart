import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/user_roles.dart';
import 'package:flutter_shop_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final claims = Provider.of<UserProvider>(context, listen: true).claims;
    final name = claims[ClaimTypes.name] as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("$name's Profile"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
