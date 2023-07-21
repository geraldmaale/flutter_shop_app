import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<BoxShadow> shadowList = [
    BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 30,
        offset: const Offset(0, 10))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Center(child: Text("Settings")),
    );
  }
}
