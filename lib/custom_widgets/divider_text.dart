import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  const DividerText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(width: 16.0),
        Text('Or sign up via' , style: TextStyle(fontSize: 16.0),),
        SizedBox(width: 16.0),
        Expanded(child: Divider()),
      ],
    );
  }
}
