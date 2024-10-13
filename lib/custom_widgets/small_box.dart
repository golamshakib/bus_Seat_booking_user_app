import 'package:flutter/material.dart';

class SmallBox extends StatelessWidget {
  const SmallBox({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          color: color,
        ),
        const SizedBox(width: 5.0),
        Text(label, style: const TextStyle(fontSize: 16.0),),
      ],
    );
  }
}
