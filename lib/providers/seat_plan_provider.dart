import 'package:bus_seat_booking_user/models/date_model.dart';
import 'package:bus_seat_booking_user/models/schedule_model.dart';
import 'package:bus_seat_booking_user/utils/constants.dart';
import 'package:flutter/foundation.dart';

class SeatPlanProvider with ChangeNotifier{

  final List<String> _seatList = [];
  final List<String> _selectedSeatNumber = [];

  List<String> get seatList => _seatList;
  List<String> get selectedSeatNumber => _selectedSeatNumber;

  String get getAllSelectedSeat => selectedSeatNumber.join(', ');

  late ScheduleModel scheduleModel;
  late DateModel dateModel;
  num _totalSeat = 0;
  num _crossAxisCount = 0;
  num _mainAxisCount = 0;
  num _passageIndex = 0;

  num get totalSeat => _totalSeat;
  num get crossAxisCount => _crossAxisCount;
  num get mainAxisCount => _mainAxisCount;
  num get passageIndex => _passageIndex;

  init(ScheduleModel schedule, DateModel date){
    _seatList.clear();
    _selectedSeatNumber.clear();
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
  }

  selectSeat(String label){
    _selectedSeatNumber.add(label);
    notifyListeners();
  }
  deSelectSeat(String label){
    _selectedSeatNumber.remove(label);
    notifyListeners();
  }

}