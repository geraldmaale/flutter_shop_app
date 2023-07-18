import 'package:flutter/material.dart';

class ShowClaimsScreen extends StatefulWidget {
  final Map<String, dynamic> claims;
  const ShowClaimsScreen({super.key, required this.claims});

  @override
  State<ShowClaimsScreen> createState() => _ShowClaimsScreenState();
}

class _ShowClaimsScreenState extends State<ShowClaimsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.claims["name"].toString().toUpperCase()}\'s Claims'),
      ),
      body: Center(child: claimsList(context, widget.claims)),
    );
  }
}

// Create a listview with a list of items
Widget claimsList(BuildContext context, Map<String, dynamic> claims) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
    ),
    padding: const EdgeInsets.only(
      top: 8,
      left: 32,
      right: 3,
    ),
    child: ListView.builder(
      itemCount: claims.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            claims.keys.elementAt(index),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          subtitle: Text(
            claims.values.elementAt(index).toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      },
    ),
  );
}
