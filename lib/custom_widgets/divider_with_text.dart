import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 20.0)),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 120.0),
          child: Divider(height: 10, color: Colors.grey),
        )
      ],
    );
  }
}
