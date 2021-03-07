import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  EmptyCard({@required this.text, this.subText});

  final String text;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Icon(
              Icons.border_clear,
              color: Colors.white,
              size: 250,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subText != null && subText != '')
                  Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
