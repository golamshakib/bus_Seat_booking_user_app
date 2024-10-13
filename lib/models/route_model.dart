class RouteModel {
  String? id;
  String routeName;
  String startLocation;
  String endLocation;
  double distance;
  double? duration;

  RouteModel({
    this.id,
    required this.routeName,
    required this.startLocation,
    required this.endLocation,
    required this.distance,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routeName': routeName,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'distance': distance,
      'duration': duration,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'],
      routeName: map['routeName'] ?? '',
      startLocation: map['startLocation'] ?? '',
      endLocation: map['endLocation'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
      duration: map['duration']?.toDouble(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
