import 'package:flutter/material.dart';

class BookingSuccessfulPage extends StatelessWidget {
  static const String routeName = '/booking_successful';

  const BookingSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final userName = argList[0];
    final customerName = argList[1];
    final bookingId = argList[2];
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/done.png',
                width: 500,
                height: 500,
              ),
              Text(
                'Congratulation! $userName\nYour booking for $customerName is successful.\n'
                'Your Booking id is:\n$bookingId',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Back to Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
