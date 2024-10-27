import 'package:bus_seat_booking_user/db/db_helper.dart';
import 'package:bus_seat_booking_user/models/booking_model.dart';
import 'package:bus_seat_booking_user/models/date_model.dart';
import 'package:bus_seat_booking_user/models/schedule_model.dart';
import 'package:bus_seat_booking_user/utils/constants.dart';
import 'package:flutter/foundation.dart';

class SeatPlanProvider with ChangeNotifier{

  List<BookingModel> _bookingSeatList = [];

  final List<String> _bookedSeatNumbers = [];
  List<String> get bookedSeatNumbers => _bookedSeatNumbers;

  final List<String> _seatList = [];
  List<String> get seatList => _seatList;

  final List<String> _selectedSeatNumber = [];
  List<String> get selectedSeatNumber => _selectedSeatNumber;

  String get getAllSelectedSeat => selectedSeatNumber.join(', ');
  bool get isAnySeatSelected => _selectedSeatNumber.isNotEmpty;
  int get totalSelectedSeats => _selectedSeatNumber.length;
  num get totalPrice => scheduleModel.ticketPrice * totalSelectedSeats;

  late ScheduleModel scheduleModel;
  late DateModel dateModel;
  num _totalSeat = 0;
  num _crossAxisCount = 0;
  num _mainAxisCount = 0;
  num _passageIndex = 0;
  num get crossAxisCount => _crossAxisCount;

  init(ScheduleModel schedule, DateModel date){
    _seatList.clear();
    _selectedSeatNumber.clear();
    _bookedSeatNumbers.clear();
    scheduleModel = schedule;
    dateModel = date;
    _totalSeat = schedule.bus.totalSeat;
    _crossAxisCount = schedule.bus.busType == BusType.acBusiness ? 4: 5;
    _passageIndex = schedule.bus.busType == BusType.acBusiness ? 1: 2;
    _mainAxisCount = (_totalSeat / (_crossAxisCount - 1)).floor();

    for (int c = 0; c < _mainAxisCount; c++) {
      for(int r = 0; r < _crossAxisCount; r++){
        String value;
        if(r == _passageIndex){
          value = '';
        }else{
          final number = r > _passageIndex ? r : r + 1;
          value = '${letters[c]}$number';
        }
        _seatList.add(value);
      }
    }
    _getAllSelectedSeatBookingsByDateAndSchedule(schedule, date);
  }

  selectSeat(String label){
    _selectedSeatNumber.add(label);
    notifyListeners();
  }
  deSelectSeat(String label){
    _selectedSeatNumber.remove(label);
    notifyListeners();
  }
  unSelectBookedSeat(List<String> bookedSets){
    _selectedSeatNumber.removeWhere((number) => bookedSets.contains(number));
    notifyListeners();
  }
  _getAllSelectedSeatBookingsByDateAndSchedule(ScheduleModel schedule, DateModel date){
    DbHelper.getAllSelectedSeatBookingsStreamByDateAndSchedule(schedule, date).listen((snapshot){
      _bookingSeatList = List.generate(snapshot.docs.length, (index) =>
          BookingModel.fromMap(snapshot.docs[index].data()));
      for(final booking in _bookingSeatList){
        _bookedSeatNumbers.addAll(booking.selectedSeatNumbers);
      }
      notifyListeners();
    });
  }


}