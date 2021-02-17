import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  ErrorBox({this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Container();
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        color: Colors.red,
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                '$message: Por favor, tente novamente!',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
      );
    }
  }
}
