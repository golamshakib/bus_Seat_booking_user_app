import 'package:bus_seat_booking_user/models/route_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bus_model.dart';

class ScheduleModel {
  String? scheduleId;
  BusModel bus;
  RouteModel route;
  Timestamp departureTimestamp;
  String departureTime;
  num ticketPrice;
  num discountPrice;

  ScheduleModel({
    this.scheduleId,
    required this.bus,
    required this.route,
    required this.departureTimestamp,
    required this.departureTime,
    required this.ticketPrice,
    this.discountPrice = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'scheduleId': scheduleId,
      'bus': bus.toMap(),
      'route': route.toMap(),
      'departureTimestamp': departureTimestamp,
      'departureTime': departureTime,
      'ticketPrice': ticketPrice,
      'discountPrice': discountPrice,
    };
  }

  factory ScheduleModel.fromMap(Map<String,dynamic> map) {
    return ScheduleModel(
      scheduleId: map['scheduleId'],
      bus: BusModel.fromMap(map['bus']),
      route: RouteModel.fromMap(map['route']),
      departureTimestamp: map['departureTimestamp'],
      departureTime: map['departureTime'],
      ticketPrice: map['ticketPrice'],
      discountPrice: map['discountPrice'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleModel &&
          runtimeType == other.runtimeType &&
          scheduleId == other.scheduleId;

  @override
  int get hashCode => scheduleId.hashCode;
}