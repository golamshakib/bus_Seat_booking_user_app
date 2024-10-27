import 'package:bus_seat_booking_user/custom_widgets/divider_with_text.dart';
import 'package:bus_seat_booking_user/models/booking_model.dart';
import 'package:bus_seat_booking_user/pages/booking_successful_page.dart';
import 'package:bus_seat_booking_user/pages/search_page.dart';
import 'package:bus_seat_booking_user/pages/seat_plan_page.dart';
import 'package:bus_seat_booking_user/providers/booking_provider.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/providers/seat_plan_provider.dart';
import 'package:bus_seat_booking_user/utils/helper_functions.dart';
import 'package:bus_seat_booking_user/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../exception/seat_already_booked_exception.dart';
import '../models/user_model.dart';

class ConfirmBookingPage extends StatefulWidget {
  static const String routeName = '/confirm_booking';

  const ConfirmBookingPage({super.key});

  @override
  State<ConfirmBookingPage> createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late UserModel userModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    context.read<FirebaseAuthProvider>().getUserInfo().then((_) {
      userModel = context.read<FirebaseAuthProvider>().userModel!;
      setState(() {
        _nameController.text = userModel.fullName;
        _phoneController.text = userModel.number;
        _emailController.text = userModel.email;
        _addressController.text = userModel.address;
      });
    }).catchError((error) {
      throw Exception(error.toString());
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: Consumer<SeatPlanProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(
            children: [
              const DividerWithText(label: 'Booking summary:'),
              Text('Bus name: ${provider.scheduleModel.bus.busName}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Bus number: ${provider.scheduleModel.bus.busNumber}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Bus type: ${provider.scheduleModel.bus.busType}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Route name: ${provider.scheduleModel.route.routeName}',
                  style: const TextStyle(fontSize: 20.0)),
              Text(
                'Departure date: ${getFormatedDateTime(DateTime.fromMillisecondsSinceEpoch(provider.dateModel.timestamp), pattern: 'MMMM d, yyyy')}',
                style: const TextStyle(fontSize: 20.0),
              ),
              Text('Departure time: ${provider.scheduleModel.departureTime}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Total selected seats: ${provider.totalSelectedSeats}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Seats number: ${provider.getAllSelectedSeat}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Ticket Price: ${provider.scheduleModel.ticketPrice}',
                  style: const TextStyle(fontSize: 20.0)),
              Text('Total Price: ${provider.totalPrice}',
                  style: const TextStyle(fontSize: 20.0)),
              const SizedBox(height: 20.0),
              const DividerWithText(label: 'Customer information:'),
              _customerFormField(),
              Center(
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: const Text(
                    'CONFIRM',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customerFormField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Full name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide full name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Mobile number',
                  prefixIcon: const Icon(Icons.call),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide mobile number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide Email address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  hintText: 'Address',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide address';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<SeatPlanProvider>();
      final customerName = _nameController.text;
      final booking = BookingModel(
        id: generateBookingId(_nameController.text),
        userModel: userModel,
        scheduleModel: provider.scheduleModel,
        dateModel: provider.dateModel,
        totalSelectedSeat: provider.totalSelectedSeats,
        selectedSeatNumbers: provider.selectedSeatNumber,
        totalPrice: provider.totalPrice,
      );
      EasyLoading.show(status: 'Please wait...');
      context.read<BookingProvider>().addBooking(booking).then((_) {
        EasyLoading.dismiss();
        Navigator.pushNamedAndRemoveUntil(
          context,
          BookingSuccessfulPage.routeName,
          ModalRoute.withName(SearchPage.routeName),
          arguments: [booking.userModel.fullName, customerName , booking.id]
        );
      }).catchError((error) {
        EasyLoading.dismiss();
        if (error is SeatAlreadyBookedException) {
          context.read<SeatPlanProvider>().unSelectBookedSeat(error.bookedSeats);
          Navigator.popUntil(context, ModalRoute.withName(SeatPlanPage.routeName));
        }
        showMsg(context, error.toString(), false);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
