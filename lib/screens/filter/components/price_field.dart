import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  PriceField({this.label, this.onChanged, this.initialValue});
  final String label;
  final Function(num) onChanged;
  final int initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixText: 'R\$ ',
          border: OutlineInputBorder(),
          isDense: true,
          labelText: label,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
        ),
        onChanged: (text) {
          onChanged(num.tryParse(text.replaceAll(',', '.')));
        },
        initialValue: initialValue?.toString(),
      ),
    );
  }
}
