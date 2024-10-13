
class DateModel {

  int year;
  int month;
  int day;
  int timestamp;

  DateModel({
    required this.year,
    required this.month,
    required this.day,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'timestamp': timestamp,
    };
  }

  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
      year: map['year'],
      month: map['month'],
      day: map['day'],
      timestamp: map['timestamp'],
    );
  }
}