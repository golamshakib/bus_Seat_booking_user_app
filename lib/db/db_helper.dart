import 'package:bus_seat_booking_user/models/date_model.dart';
import 'package:bus_seat_booking_user/models/schedule_model.dart';
import 'package:bus_seat_booking_user/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../exception/seat_already_booked_exception.dart';
import '../models/booking_model.dart';

class DbHelper {
  DbHelper._();

  static final _db = FirebaseFirestore.instance;
  static const String _collectionBus = 'Buses';
  static const String _collectionRoute = 'Routes';
  static const String _collectionSchedule = 'Schedules';
  static const String _collectionUser = 'Users';
  static const String _collectionBooking = 'Bookings';

  // I N S E R T
  static Future<void> saveNewUser(UserModel user) {
    final doc = _db.collection(_collectionUser).doc(user.id);
    return doc.set(user.toMap());
  }

  static Future<void> addBooking(BookingModel booking) async {
    final snapshot = await getAllSelectedSeatBookingsByDateAndSchedule(
        booking.scheduleModel, booking.dateModel);
    final bookingList = List.generate(snapshot.docs.length,
        (index) => BookingModel.fromMap(snapshot.docs[index].data()));
    final bookedSeatNumbers = <String>[];
    for (final booked in bookingList) {
      bookedSeatNumbers.addAll(booked.selectedSeatNumbers);
    }
    final selectedSeatNumbers = booking.selectedSeatNumbers;
    final isAnySeatSelected = bookedSeatNumbers.any((number) {
      return selectedSeatNumbers.contains(number);
    });
    if (isAnySeatSelected) {
      throw SeatAlreadyBookedException(
        bookedSeatNumbers
            .where((number) => selectedSeatNumbers.contains(number))
            .toList(),
      );
    }
    final doc = _db.collection(_collectionBooking).doc(booking.id);
    return await doc.set(booking.toMap());
  }

  // Q U E R Y
  static Future<DocumentSnapshot> getUserInfo(String id) {
    return _db.collection(_collectionUser).doc(id).get();
  }

  static Future<bool> doesUserExit(String id) async {
    final snapshot = await _db.collection(_collectionBooking).doc(id).get();
    return snapshot.exists;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllSelectedSeatBookingsStreamByDateAndSchedule(
          ScheduleModel schedule, DateModel date) {
    return _db
        .collection(_collectionBooking)
        .where('scheduleModel.scheduleId', isEqualTo: schedule.scheduleId)
        .where('dateModel.day', isEqualTo: date.day)
        .where('dateModel.month', isEqualTo: date.month)
        .where('dateModel.year', isEqualTo: date.year)
        .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>>
      getAllSelectedSeatBookingsByDateAndSchedule(
          ScheduleModel schedule, DateModel date) {
    return _db
        .collection(_collectionBooking)
        .where('scheduleModel.scheduleId', isEqualTo: schedule.scheduleId)
        .where('dateModel.day', isEqualTo: date.day)
        .where('dateModel.month', isEqualTo: date.month)
        .where('dateModel.year', isEqualTo: date.year)
        .get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBuses() {
    return _db.collection(_collectionBus).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRoutes() {
    return _db.collection(_collectionRoute).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBookingsByUser(
      String id) {
    return _db
        .collection(_collectionBooking)
        .where('userModel.id', isEqualTo: id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllSchedulesByStartAndEndLocation(String start, String end) {
    return _db
        .collection(_collectionSchedule)
        .where('route.startLocation', isEqualTo: start)
        .where('route.endLocation', isEqualTo: end)
        .snapshots();
  }

  // U P D A T E
  static Future<void> updateUserProfile(UserModel user) async {
    await _db.collection(_collectionUser).doc(user.id).update(user.toMap());
  }
}
