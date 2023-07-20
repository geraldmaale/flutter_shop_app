import 'package:flutter/material.dart';

void showSnackBarError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,
          style: TextStyle(
            color: Colors.grey[400],
          )),
      backgroundColor: Theme.of(context).colorScheme.error,
      action: SnackBarAction(
        textColor: Colors.grey[400],
        label: 'Ok',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}

class SnackBarUtils extends StatelessWidget {
  const SnackBarUtils({Key? key}) : super(key: key);

  void showSnackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(
              color: Colors.grey[400],
            )),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          textColor: Colors.grey[400],
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
