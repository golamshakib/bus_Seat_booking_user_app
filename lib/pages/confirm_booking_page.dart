import 'package:flutter/material.dart';

class ConfirmBookingPage extends StatefulWidget {
  static const String routeName = '/confirm_booking';
  const ConfirmBookingPage({super.key});

  @override
  State<ConfirmBookingPage> createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking'),),
    );
  }
}
