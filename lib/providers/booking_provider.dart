import 'package:bus_seat_booking_user/models/booking_model.dart';
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/bus_model.dart';
import '../models/schedule_model.dart';

class BookingProvider with ChangeNotifier{

  List<BusModel> _busList = [];
  List<BusModel> get busList => _busList;

  List<ScheduleModel> _scheduleList = [];
  List<ScheduleModel> get scheduleList => _scheduleList;

  List<BookingModel> _userBookingList = [];
  List<BookingModel> get userBookingList => _userBookingList;

  // S E T

  Future<void> addBooking (BookingModel booking) {
    return DbHelper.addBooking(booking);
  }

  // G E T
  getAllBuses() {
    DbHelper.getAllBuses().listen((snapshot){
      _busList = List.generate(snapshot.docs.length, (index) =>
          BusModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllBookingsByUser(String id){
    DbHelper.getAllBookingsByUser(id).listen((snapshot){
      _userBookingList = List.generate(snapshot.docs.length, (index) =>
      BookingModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllSchedulesByStartAndEndLocation(String start, String end){
    DbHelper.getAllSchedulesByStartAndEndLocation(start, end).listen((snapshot){
      _scheduleList = List.generate(snapshot.docs.length, (index) =>
          ScheduleModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

}