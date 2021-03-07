import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  BarButton({this.label, this.decoration, this.onTap});

  final String label;
  final BoxDecoration decoration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: decoration,
          height: 40,
          child: Text(
            '$label',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
