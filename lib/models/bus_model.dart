class BusModel {
  String? id;
  String busName;
  String busNumber;
  String busType;
  num totalSeat;
  String? busImage;

  BusModel({
    this.id,
    required this.busName,
    required this.busNumber,
    required this.busType,
    required this.totalSeat,
    this.busImage,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'busName': busName,
      'busNumber': busNumber,
      'busType': busType,
      'totalSeat': totalSeat,
      'busImage': busImage,
    };
  }

  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      id: map['id'],
      busName: map['busName'],
      busNumber: map['busNumber'],
      busType: map['busType'],
      totalSeat: map['totalSeat'],
      busImage: map['busImage'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}