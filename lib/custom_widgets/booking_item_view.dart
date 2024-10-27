import 'package:bus_seat_booking_user/models/booking_model.dart';
import 'package:bus_seat_booking_user/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BookingItemView extends StatelessWidget {
  const BookingItemView({
    super.key,
    required this.bookingModel,
    required this.index,
  });

  final BookingModel bookingModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Text(
          '${index + 1}.',
          style: const TextStyle(fontSize: 16.0),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingModel.scheduleModel.bus.busName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text('Bus No: ${bookingModel.scheduleModel.bus.busNumber}',
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('Departure Date: ${getFormatedDateTime(DateTime.fromMillisecondsSinceEpoch(bookingModel.dateModel.timestamp), pattern: 'MMMM d, yyyy')}',
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Route name: ${bookingModel.scheduleModel.route.routeName}',
                style: const TextStyle(fontSize: 15)),
            Text('Departure time: ${bookingModel.scheduleModel.departureTime}',
                style: const TextStyle(fontSize: 15)),
            Text('Ticket Price: ${bookingModel.scheduleModel.ticketPrice}',
                style: const TextStyle(fontSize: 15)),
            Text('Selected seats: ${bookingModel.totalSelectedSeat}',
                style: const TextStyle(fontSize: 15)),
            Text('Seat numbers: ${bookingModel.selectedSeatNumbers}',
                style: const TextStyle(fontSize: 15)),
            Text('Total price: ${bookingModel.totalPrice}',
                style: const TextStyle(fontSize: 15)),
          ],
        ),
        trailing: Column(
          children: [
            Text(bookingModel.scheduleModel.bus.busType,
                style: const TextStyle(fontSize: 16.0)),
            Text('$currency ${bookingModel.scheduleModel.ticketPrice.toString()}',
                style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
