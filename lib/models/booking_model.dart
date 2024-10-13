import 'package:bus_seat_booking_user/models/date_model.dart';
import 'package:bus_seat_booking_user/models/schedule_model.dart';
import 'package:bus_seat_booking_user/models/user_model.dart';

class BookingModel {
  String id;
  UserModel userModel;
  ScheduleModel scheduleModel;
  DateModel dateModel;
  num totalSeat;
  List<String> seatNumbers;
  num totalPrice;
  bool isActive;

  BookingModel({
    required this.id,
    required this.userModel,
    required this.scheduleModel,
    required this.dateModel,
    required this.totalSeat,
    required this.seatNumbers,
    required this.totalPrice,
    required this.isActive,
  });

  // Method to convert ReservationModel to a Map
  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'userModel': userModel.toMap(),
      'scheduleModel': scheduleModel.toMap(),
      'dateModel': dateModel.toMap(),
      'totalSeat': totalSeat,
      'seatNumbers': seatNumbers,
      'totalPrice': totalPrice,
      'isActive': isActive,
    };
  }

  // Factory constructor to create a ReservationModel from a Map
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      userModel: UserModel.fromMap(map['userModel']),
      scheduleModel: ScheduleModel.fromMap(map['scheduleModel']),
      dateModel: DateModel.fromMap(map['dateModel']),
      totalSeat: map['totalSeat'],
      seatNumbers: List<String>.from(map['seatNumbers']),
      totalPrice: map['totalPrice'],
      isActive: map['isActive'],
    );
  }
}