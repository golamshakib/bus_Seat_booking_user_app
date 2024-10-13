import 'package:flutter/material.dart';

// E R R O R    M E S S A G E   M E T H O D

showMsg(BuildContext context, String msg, bool isSuccess){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.only(bottom: 0.0),
      backgroundColor: Colors.transparent, // No background color
      elevation: 0, // No shadow
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          msg,
          style: TextStyle(color: isSuccess? Colors.green : Colors.redAccent,
              fontWeight: FontWeight.w500), // Text color
        ),
      ),
    ),
  );
}