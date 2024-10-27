import 'package:bus_seat_booking_user/custom_widgets/booking_item_view.dart';
import 'package:bus_seat_booking_user/providers/booking_provider.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookingPage extends StatelessWidget {
  static const String routeName = '/my_bookings';

  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookingProvider>().getAllBookingsByUser(
      context.read<FirebaseAuthProvider>().currentUser!.uid
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My bookings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<BookingProvider>(
            builder: (context, provider, child) =>
                provider.userBookingList.isEmpty
                    ? const Center(child: Text('No Bookings found'))
                    : ListView.builder(
                        itemCount: provider.userBookingList.length,
                        itemBuilder: (context, index) {
                          final booking = provider.userBookingList[index];
                          return BookingItemView(
                              bookingModel: booking, index: index);
                        },
                      )),
      ),
    );
  }
}
